package it.uniroma3.siw.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import it.uniroma3.siw.exception.FilmNotFoundException;
import it.uniroma3.siw.exception.OperazioneNonConsentitaException;
import it.uniroma3.siw.exception.RecensioneNotFoundException;
import it.uniroma3.siw.model.Film;
import it.uniroma3.siw.model.Recensione;
import it.uniroma3.siw.model.Utente;
import it.uniroma3.siw.repository.CredenzialiRepository;
import it.uniroma3.siw.repository.FilmRepository;
import it.uniroma3.siw.repository.RecensioneRepository;

@Service
public class RecensioneService {

	private final RecensioneRepository recensioneRepository;
	private final FilmRepository filmRepository;
	private final CredenzialiRepository credenzialiRepository;

	public RecensioneService(RecensioneRepository recensioneRepository, FilmRepository filmRepository,
			CredenzialiRepository credenzialiRepository) {
		this.recensioneRepository = recensioneRepository;
		this.filmRepository = filmRepository;
		this.credenzialiRepository = credenzialiRepository;
	}

	@Transactional(readOnly = true)
	public Recensione findById(Long id) {
		return this.recensioneRepository.findById(id)
				.orElseThrow(() -> new RecensioneNotFoundException(id));
	}

	// Recensioni di un film (404 se il film non esiste), con l'autore gia' caricato
	@Transactional(readOnly = true)
	public List<Recensione> delFilm(Long filmId) {
		this.filmRepository.findById(filmId).orElseThrow(() -> new FilmNotFoundException(filmId));
		return this.recensioneRepository.findByFilmIdOrderByDataDescIdDesc(filmId);
	}

	@Transactional(readOnly = true)
	public Double mediaVoti(Long filmId) {
		return this.recensioneRepository.mediaVoti(filmId);
	}

	@Transactional(readOnly = true)
	public long numero(Long filmId) {
		return this.recensioneRepository.countByFilmId(filmId);
	}

	// id dell'anagrafica (Utente) di chi e' collegato con quello username
	@Transactional(readOnly = true)
	public Long idUtente(String username) {
		return utenteDi(username).getId();
	}

	// La recensione dell'utente collegato per quel film, oppure null se non ne ha scritta una
	@Transactional(readOnly = true)
	public Recensione trovaDelloUtente(Long filmId, String username) {
		Utente utente = utenteDi(username);
		return this.recensioneRepository.findByFilmIdAndUtenteId(filmId, utente.getId()).orElse(null);
	}

	@Transactional(readOnly = true)
	public boolean isAutore(Recensione recensione, String username) {
		return recensione.getUtente().getId().equals(utenteDi(username).getId());
	}

	// Una sola recensione per utente e film: controllo qui (messaggio chiaro) e vincolo unique sul database
	// (ultima difesa anche in caso di due richieste simultanee).
	@Transactional
	public Recensione inserisci(Long filmId, String username, Recensione dati) {
		Film film = this.filmRepository.findById(filmId)
				.orElseThrow(() -> new FilmNotFoundException(filmId));
		Utente utente = utenteDi(username);
		if (this.recensioneRepository.existsByFilmIdAndUtenteId(filmId, utente.getId())) {
			throw new OperazioneNonConsentitaException("Hai già scritto una recensione per questo film");
		}
		// L'utente e il film NON arrivano dal modulo: si prendono dal login e dall'indirizzo.
		Recensione recensione = new Recensione();
		recensione.setTesto(dati.getTesto());
		recensione.setVoto(dati.getVoto());
		recensione.setData(LocalDate.now());
		recensione.setFilm(film);
		recensione.setUtente(utente);
		this.recensioneRepository.save(recensione);
		film.getRecensioni().add(recensione);
		utente.getRecensioni().add(recensione);
		return recensione;
	}

	@Transactional
	public Recensione modifica(Long id, String username, Recensione dati) {
		Recensione recensione = findById(id);
		if (!isAutore(recensione, username)) {
			throw new OperazioneNonConsentitaException("Puoi modificare solo le tue recensioni");
		}
		recensione.setTesto(dati.getTesto());
		recensione.setVoto(dati.getVoto());
		return this.recensioneRepository.save(recensione);
	}

	@Transactional
	public void elimina(Long id, String username) {
		Recensione recensione = findById(id);
		if (!isAutore(recensione, username)) {
			throw new OperazioneNonConsentitaException("Puoi eliminare solo le tue recensioni");
		}
		recensione.getFilm().getRecensioni().remove(recensione);
		recensione.getUtente().getRecensioni().remove(recensione);
		this.recensioneRepository.delete(recensione);
	}

	private Utente utenteDi(String username) {
		return this.credenzialiRepository.findByUsername(username)
				.orElseThrow(() -> new OperazioneNonConsentitaException("Utente non trovato"))
				.getUtente();
	}
}
