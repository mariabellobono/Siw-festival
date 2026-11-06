package it.uniroma3.siw.service;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import it.uniroma3.siw.exception.FestivalNotFoundException;
import it.uniroma3.siw.exception.FilmNotFoundException;
import it.uniroma3.siw.exception.OperazioneNonConsentitaException;
import it.uniroma3.siw.model.Festival;
import it.uniroma3.siw.model.Film;
import it.uniroma3.siw.model.Proiezione;
import it.uniroma3.siw.model.Stato;
import it.uniroma3.siw.repository.FestivalRepository;
import it.uniroma3.siw.repository.FilmRepository;

@Service
public class FestivalService {
	private final FestivalRepository festivalRepository;
	private final FilmRepository filmRepository;

    public FestivalService(FestivalRepository festivalRepository, FilmRepository filmRepository) {
        this.festivalRepository = festivalRepository;
        this.filmRepository = filmRepository;
    }

    @Transactional(readOnly = true)
    public Iterable<Festival> findAll() {
        return this.festivalRepository.findAll();
    }

    @Transactional(readOnly = true)
    public Festival findById(Long id) {
        return this.festivalRepository.findById(id)
                .orElseThrow(() -> new FestivalNotFoundException(id));
    }

    @Transactional
    public Festival save(Festival festival) {
        return this.festivalRepository.save(festival);
    }

    // Film che NON partecipano ancora al festival (servono per la tendina "Aggiungi film")
    @Transactional(readOnly = true)
    public List<Film> filmNonPresenti(Long festivalId) {
        Festival festival = findById(festivalId);
        List<Film> disponibili = new ArrayList<>();
        for (Film film : this.filmRepository.findAll()) {
            boolean presente = festival.getFilms().stream().anyMatch(f -> f.getId().equals(film.getId()));
            if (!presente) {
                disponibili.add(film);
            }
        }
        disponibili.sort(Comparator.comparing(Film::getTitolo));
        return disponibili;
    }

    // ASSOCIAZIONE film-festival. Il lato PROPRIETARIO della relazione e' Film.festival
    // (e' li' che Hibernate scrive la tabella film_festival), ma si aggiornano entrambi i lati
    // per tenere coerenti gli oggetti in memoria.
    @Transactional
    public void aggiungiFilm(Long festivalId, Long filmId) {
        Festival festival = findById(festivalId);
        Film film = this.filmRepository.findById(filmId)
                .orElseThrow(() -> new FilmNotFoundException(filmId));
        boolean gia = film.getFestival().stream().anyMatch(f -> f.getId().equals(festivalId));
        if (gia) {
            throw new OperazioneNonConsentitaException("Il film partecipa già a questo festival");
        }
        film.getFestival().add(festival);
        festival.getFilms().add(film);
    }

    // RIMOZIONE film dal festival. Consistenza: se il film ha proiezioni ancora programmate
    // in questo festival non si puo' togliere (resterebbe una proiezione di un film che nel
    // festival non c'e' piu'). Le proiezioni gia' svolte o annullate non bloccano.
    @Transactional
    public void rimuoviFilm(Long festivalId, Long filmId) {
        Festival festival = findById(festivalId);
        Film film = this.filmRepository.findById(filmId)
                .orElseThrow(() -> new FilmNotFoundException(filmId));
        for (Proiezione p : festival.getProiezioni()) {
            if (p.getFilm().getId().equals(filmId) && p.getStato() == Stato.SCHEDULED) {
                throw new OperazioneNonConsentitaException(
                        "Prima annulla le proiezioni programmate di questo film in questo festival");
            }
        }
        film.getFestival().removeIf(f -> f.getId().equals(festivalId));
        festival.getFilms().removeIf(f -> f.getId().equals(filmId));
    }
}
