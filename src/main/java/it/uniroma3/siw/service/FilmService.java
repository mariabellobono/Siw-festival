package it.uniroma3.siw.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import it.uniroma3.siw.exception.FilmNotFoundException;
import it.uniroma3.siw.exception.OperazioneNonConsentitaException;
import it.uniroma3.siw.model.Film;
import it.uniroma3.siw.repository.FilmRepository;

@Service
public class FilmService {
	
	private final FilmRepository filmRepository;
	
	public FilmService(FilmRepository filmRepository) {
		this.filmRepository = filmRepository;
		
	}
	@Transactional(readOnly = true)
	public Iterable<Film> findAll(){
		return this.filmRepository.findAll();
	}
	
	@Transactional(readOnly = true)
    public Film findById(Long id) {
        return this.filmRepository.findById(id)
                .orElseThrow(() -> new FilmNotFoundException(id));
    }
	// Film + festival in una query sola (per il dettaglio dell'API, senza dipendere da sessioni aperte)
	@Transactional(readOnly = true)
	public Film findDettaglio(Long id) {
		return this.filmRepository.findWithFestivalById(id)
				.orElseThrow(() -> new FilmNotFoundException(id));
	}

	@Transactional(readOnly = true)
	public boolean existsByTitoloAndAnno(String titolo,Integer anno) {
		return this.filmRepository.existsByTitoloAndAnno(titolo, anno);
	}
	
	@Transactional
	public Film save(Film film) {
		return this.filmRepository.save(film);
	}

	@Transactional(readOnly = true)
	public boolean existsByTitoloAndAnnoAndIdNot(String titolo, Integer anno, Long id) {
		return this.filmRepository.existsByTitoloAndAnnoAndIdNot(titolo, anno, id);
	}

	// MODIFICA: si carica il film dal database e si copiano solo i campi del modulo.
	// Non si salva direttamente l'oggetto arrivato dal browser: avrebbe le liste vuote
	// (festival, proiezioni, recensioni, interpretazioni) e cancellerebbe le associazioni esistenti.
	@Transactional
	public Film aggiorna(Long id, Film dati) {
		Film film = this.filmRepository.findById(id)
				.orElseThrow(() -> new FilmNotFoundException(id));
		film.setTitolo(dati.getTitolo());
		film.setAnno(dati.getAnno());
		film.setDurata(dati.getDurata());
		film.setGenere(dati.getGenere());
		film.setPaeseProduzione(dati.getPaeseProduzione());
		film.setRegista(dati.getRegista());
		return this.filmRepository.save(film);
	}

	@Transactional(readOnly = true)
	public List<Film> findByRegista(String regista) {
		return this.filmRepository.findByRegistaOrderByAnno(regista);
	}

	// RICERCA + PAGINAZIONE (usata dall'API). I filtri null diventano "" (= nessun filtro);
	// la dimensione della pagina e' limitata a 50 per non caricare tutto in una volta.
	@Transactional(readOnly = true)
	public Page<Film> cerca(String titolo, String genere, String regista, int pagina, int dimensione) {
		int dim = Math.min(Math.max(dimensione, 1), 50);
		return this.filmRepository.cerca(pulisci(titolo), pulisci(genere), pulisci(regista),
				PageRequest.of(Math.max(pagina, 0), dim));
	}

	@Transactional(readOnly = true)
	public List<String> generi() {
		return this.filmRepository.findGeneri();
	}

	// ELIMINAZIONE: un film ancora usato (proiezioni, recensioni, cast) non si cancella,
	// altrimenti si romperebbero i collegamenti (chiavi esterne). Le righe film_festival,
	// invece, le toglie Hibernate da solo perche' Film e' il lato proprietario della relazione.
	@Transactional
	public void elimina(Long id) {
		Film film = findById(id);
		
		this.filmRepository.delete(film);
	}

	// ELENCO ORDINATO: "ordina" arriva dall'indirizzo (?ordina=anno). Valore assente o sconosciuto = per titolo.
	@Transactional(readOnly = true)
	public List<Film> elenco(String ordina) {
		if ("titolo-desc".equals(ordina)) {
			return this.filmRepository.findAllByOrderByTitoloDesc();
		}
		if ("anno".equals(ordina)) {
			return this.filmRepository.findAllByOrderByAnnoAsc();
		}
		if ("anno-desc".equals(ordina)) {
			return this.filmRepository.findAllByOrderByAnnoDesc();
		}
		if ("regista".equals(ordina)) {
			return this.filmRepository.findAllByOrderByRegistaAsc();
		}
		return this.filmRepository.findAllByOrderByTitoloAsc();
	}

	@Transactional(readOnly = true)
	public List<Film> findByGenere(String genere) {
		return this.filmRepository.findByGenereOrderByTitolo(genere);
	}

	// CONTEGGI (select count(*) nel database: piu' efficiente che caricare la lista e contarla)
	@Transactional(readOnly = true)
	public long numero() {
		return this.filmRepository.count();
	}

	@Transactional(readOnly = true)
	public long numeroPerGenere(String genere) {
		return this.filmRepository.countByGenere(genere);
	}

	@Transactional(readOnly = true)
	public long numeroPerRegista(String regista) {
		return this.filmRepository.countByRegista(regista);
	}

	@Transactional(readOnly = true)
	public long numeroDelFestival(Long festivalId) {
		return this.filmRepository.countByFestivalId(festivalId);
	}

	private String pulisci(String testo) {
		return testo == null ? "" : testo.trim();
	}
}
