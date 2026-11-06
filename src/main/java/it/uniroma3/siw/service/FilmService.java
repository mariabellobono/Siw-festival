package it.uniroma3.siw.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import it.uniroma3.siw.exception.FilmNotFoundException;
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
}
