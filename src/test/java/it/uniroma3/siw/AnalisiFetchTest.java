package it.uniroma3.siw;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Supplier;

import org.hibernate.SessionFactory;
import org.hibernate.stat.Statistics;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.support.TransactionTemplate;

import it.uniroma3.siw.model.Film;
import it.uniroma3.siw.model.Proiezione;
import it.uniroma3.siw.repository.FilmRepository;
import it.uniroma3.siw.repository.ProiezioneRepository;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceContext;

/**
 * ANALISI SPERIMENTALE DELL'ACCESSO AI DATI (sezione 8.2 del progetto).
 *
 * COME SI ESEGUE: con l'applicazione FERMA, clic destro su questo file -> Run As -> JUnit Test.
 * (Il test avvia Spring, che ricrea il database da import.sql, come l'applicazione.)
 * I risultati si leggono nella console.
 *
 * COSA FA: esegue lo STESSO caso d'uso con strategie diverse, sugli STESSI dati, e per ciascuna stampa
 * record caricati, entita' caricate da Hibernate, numero di query SQL e tempo.
 * Il conteggio delle query viene dalle statistiche di Hibernate (generate_statistics).
 *
 * MOTIVAZIONI DELLE SCELTE DI FETCH (sezione 8.1):
 * - @OneToMany e @ManyToMany sono LAZY (default JPA): sono collezioni potenzialmente grandi
 *   (un film ha proiezioni e recensioni, un festival ha proiezioni): si caricano solo quando servono.
 *   Dove una pagina ne ha bisogno, si usa EntityGraph/JOIN FETCH per evitare le N+1 query.
 * - @ManyToOne e' EAGER (default JPA): e' un solo oggetto che serve quasi sempre insieme alla
 *   proiezione/recensione; inoltre le equals() delle entita' usano getClass() e i campi, e non
 *   funzionerebbero con i proxy LAZY. Il costo e' l'N+1 sulle query di elenco: per quelle si usa EntityGraph.
 */
@SpringBootTest(properties = {
		"spring.jpa.properties.hibernate.generate_statistics=true",
		"spring.jpa.show-sql=false",
		"logging.level.org.hibernate.SQL=off",
		"logging.level.org.hibernate.type.descriptor.sql=off"
})
class AnalisiFetchTest {

	@Autowired
	private EntityManagerFactory emf;

	@Autowired
	private PlatformTransactionManager transactionManager;

	@PersistenceContext
	private EntityManager em;

	@Autowired
	private ProiezioneRepository proiezioneRepository;

	@Autowired
	private FilmRepository filmRepository;

	@Test
	void confrontaStrategieDiAccessoAiDati() {
		Statistics stats = emf.unwrap(SessionFactory.class).getStatistics();
		stats.setStatisticsEnabled(true);
		TransactionTemplate tx = new TransactionTemplate(transactionManager);
		tx.setReadOnly(true);

		// CASO D'USO 1: programma delle proiezioni, con film, sala e festival di ciascuna
		Map<String, Supplier<Integer>> caso1 = new LinkedHashMap<>();
		caso1.put("Select semplice (associazioni EAGER: N+1)", () -> {
			List<Proiezione> lista = em.createQuery("select p from Proiezione p", Proiezione.class).getResultList();
			lista.forEach(this::leggiAssociazioni);
			return lista.size();
		});
		caso1.put("JOIN FETCH", () -> {
			List<Proiezione> lista = em.createQuery(
					"select p from Proiezione p join fetch p.film join fetch p.sala join fetch p.festival",
					Proiezione.class).getResultList();
			lista.forEach(this::leggiAssociazioni);
			return lista.size();
		});
		caso1.put("EntityGraph (repository)", () -> {
			List<Proiezione> lista = proiezioneRepository.findAllConDettagli();
			lista.forEach(this::leggiAssociazioni);
			return lista.size();
		});
		confronta("TEST 1 - Proiezioni con film, sala e festival", caso1, stats, tx);

		// CASO D'USO 2: tutti i film, con l'elenco dei festival a cui partecipano (collezione LAZY)
		Map<String, Supplier<Integer>> caso2 = new LinkedHashMap<>();
		caso2.put("LAZY (una query per ogni film: N+1)", () -> {
			List<Film> lista = em.createQuery("select f from Film f", Film.class).getResultList();
			lista.forEach(f -> f.getFestival().size());
			return lista.size();
		});
		caso2.put("JOIN FETCH", () -> {
			List<Film> lista = em.createQuery("select distinct f from Film f left join fetch f.festival", Film.class)
					.getResultList();
			lista.forEach(f -> f.getFestival().size());
			return lista.size();
		});
		caso2.put("EntityGraph (repository)", () -> {
			List<Film> lista = filmRepository.findAllConFestival();
			lista.forEach(f -> f.getFestival().size());
			return lista.size();
		});
		confronta("TEST 2 - Film con i festival a cui partecipano", caso2, stats, tx);
	}

	// Legge film, sala e festival: se non sono gia' stati caricati, Hibernate fa altre query qui
	private void leggiAssociazioni(Proiezione p) {
		p.getFilm().getTitolo();
		p.getSala().getNome();
		p.getFestival().getNome();
	}

	private void confronta(String titolo, Map<String, Supplier<Integer>> strategie, Statistics stats,
			TransactionTemplate tx) {
		System.out.println();
		System.out.println("=== " + titolo + " ===");
		int numero = 1;
		for (Map.Entry<String, Supplier<Integer>> strategia : strategie.entrySet()) {
			// giro di riscaldamento (non misurato): la prima esecuzione e' piu' lenta per motivi di avvio
			tx.execute(status -> strategia.getValue().get());

			stats.clear(); // azzera i contatori: si misura solo questa strategia
			long inizio = System.nanoTime();
			Integer record = tx.execute(status -> strategia.getValue().get());
			long millisecondi = (System.nanoTime() - inizio) / 1_000_000;

			System.out.println();
			System.out.println("Strategia " + numero + ": " + strategia.getKey());
			System.out.println("  Record caricati:           " + record);
			System.out.println("  Entita' caricate (Hibernate): " + stats.getEntityLoadCount());
			System.out.println("  Query SQL:                 " + stats.getPrepareStatementCount());
			System.out.println("  Tempo:                     " + millisecondi + " ms");
			numero++;
		}
		System.out.println();
	}
}
