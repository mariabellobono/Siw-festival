package it.uniroma3.siw.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import it.uniroma3.siw.model.Film;

public interface FilmRepository extends CrudRepository<Film, Long> {
	boolean existsByTitoloAndAnno(String titolo, Integer anno);

	// Per la modifica: esiste un ALTRO film (id diverso) con lo stesso titolo e anno?
	boolean existsByTitoloAndAnnoAndIdNot(String titolo, Integer anno, Long id);

	// Film di un regista, dal piu' vecchio al piu' recente (OrderByAnno = ORDER BY anno)
	List<Film> findByRegistaOrderByAnno(String regista);

	// Tutti i film CON i festival a cui partecipano (collezione LAZY) in una sola query.
	@EntityGraph(attributePaths = "festival")
	@Query("select f from Film f order by f.titolo")
	List<Film> findAllConFestival();

	// RICERCA per l'API: titolo, genere e regista contengono il testo (senza distinguere maiuscole).
	// Con "" (stringa vuota) la condizione e' sempre vera: per questo il service non passa mai null
	// (PostgreSQL non riesce a dedurre il tipo di un parametro null dentro lower(concat(...))).
	// Pageable = quale pagina e quanti risultati; Page = i risultati + il totale per la paginazione.
	@Query("select f from Film f where lower(f.titolo) like lower(concat('%', :titolo, '%')) "
			+ "and lower(f.genere) like lower(concat('%', :genere, '%')) "
			+ "and lower(f.regista) like lower(concat('%', :regista, '%')) order by f.titolo")
	Page<Film> cerca(@Param("titolo") String titolo, @Param("genere") String genere,
			@Param("regista") String regista, Pageable pageable);

	// Un film con i suoi festival (collezione LAZY) caricati nella stessa query: per il dettaglio dell'API
	@EntityGraph(attributePaths = "festival")
	Optional<Film> findWithFestivalById(Long id);

	// Elenco dei generi presenti (senza doppioni) per il menu a tendina di ricerca
	@Query("select distinct f.genere from Film f order by f.genere")
	List<String> findGeneri();

	// ORDINAMENTI: la parola chiave OrderBy + il campo + Asc/Desc diventa l'"order by" della query
	List<Film> findAllByOrderByTitoloAsc();
	List<Film> findAllByOrderByTitoloDesc();
	List<Film> findAllByOrderByAnnoAsc();
	List<Film> findAllByOrderByAnnoDesc();
	List<Film> findAllByOrderByRegistaAsc();

	// FILTRO per genere (valore esatto), in ordine di titolo
	List<Film> findByGenereOrderByTitolo(String genere);

	// CONTEGGI fatti dal database: countBy... = select count(*) ... where ...
	long countByGenere(String genere);
	long countByRegista(String regista);
	long countByFestivalId(Long festivalId);

}
