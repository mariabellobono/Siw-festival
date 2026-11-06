package it.uniroma3.siw.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import it.uniroma3.siw.dto.ProiezioneForm;
import it.uniroma3.siw.exception.FestivalNotFoundException;
import it.uniroma3.siw.exception.FilmNotFoundException;
import it.uniroma3.siw.exception.ProgrammazioneNonValidaException;
import it.uniroma3.siw.exception.ProiezioneNotFoundException;
import it.uniroma3.siw.exception.SalaNotFoundException;
import it.uniroma3.siw.model.Festival;
import it.uniroma3.siw.model.Film;
import it.uniroma3.siw.model.Proiezione;
import it.uniroma3.siw.model.Sala;
import it.uniroma3.siw.model.Stato;
import it.uniroma3.siw.repository.FestivalRepository;
import it.uniroma3.siw.repository.FilmRepository;
import it.uniroma3.siw.repository.ProiezioneRepository;
import it.uniroma3.siw.repository.SalaRepository;

@Service
public class ProiezioneService {

	private final ProiezioneRepository proiezioneRepository;
	private final FestivalRepository festivalRepository;
	private final FilmRepository filmRepository;
	private final SalaRepository salaRepository;

	public ProiezioneService(ProiezioneRepository proiezioneRepository, FestivalRepository festivalRepository,
			FilmRepository filmRepository, SalaRepository salaRepository) {
		this.proiezioneRepository = proiezioneRepository;
		this.festivalRepository = festivalRepository;
		this.filmRepository = filmRepository;
		this.salaRepository = salaRepository;
	}

	@Transactional(readOnly = true)
	public Iterable<Proiezione> findAll() {
		return this.proiezioneRepository.findAll();
	}

	@Transactional(readOnly = true)
	public Proiezione findById(Long id) {
		return this.proiezioneRepository.findById(id)
				.orElseThrow(() -> new ProiezioneNotFoundException(id));
	}

	// Operazione ATOMICA su piu' entita' e piu' repository (festival, film, sala, proiezione).
	// Se una qualsiasi riga lancia un'eccezione, la transazione fa rollback e non resta nulla a meta'.
	// ISOLAMENTO SERIALIZABLE: il rischio e' la corsa "controllo e poi inserimento" fra due admin
	// che programmano la stessa sala nello stesso momento. Con READ COMMITTED (default di PostgreSQL)
	// il secondo non vedrebbe ancora l'inserimento del primo e passerebbero entrambi; con SERIALIZABLE
	// una delle due transazioni fallisce (ConcurrencyFailureException) e l'admin puo' riprovare.
	@Transactional(isolation = Isolation.SERIALIZABLE)
	public Proiezione programma(ProiezioneForm form) {
		// 1-3. Recupero delle entita'
		Festival festival = caricaFestival(form.getFestivalId());
		Film film = caricaFilm(form.getFilmId());
		Sala sala = caricaSala(form.getSalaId());

		// 4. Verifica di consistenza e disponibilita' della sala
		verificaProgrammazione(festival, film, sala, form.getData(), form.getOra(), null);

		// 5. Creazione della proiezione
		Proiezione proiezione = new Proiezione();
		proiezione.setData(form.getData());
		proiezione.setOra(form.getOra());
		proiezione.setStato(Stato.SCHEDULED);
		proiezione.setFestival(festival);
		proiezione.setFilm(film);
		proiezione.setSala(sala);
		this.proiezioneRepository.save(proiezione);

		// 6. Aggiornamento delle associazioni (lato inverso, per tenere coerenti gli oggetti in memoria)
		festival.getProiezioni().add(proiezione);
		film.getProiezioni().add(proiezione);
		sala.getProiezioni().add(proiezione);

		return proiezione;
	}

	// MODIFICA di una proiezione programmata: stessi controlli della programmazione, ma
	// la proiezione stessa non conta come "sala occupata" (si escluderebbe da sola).
	@Transactional(isolation = Isolation.SERIALIZABLE)
	public Proiezione modifica(Long id, ProiezioneForm form) {
		Proiezione proiezione = this.proiezioneRepository.findById(id)
				.orElseThrow(() -> new ProiezioneNotFoundException(id));
		if (proiezione.getStato() != Stato.SCHEDULED) {
			throw new ProgrammazioneNonValidaException("Si possono modificare solo le proiezioni programmate");
		}
		Festival festival = caricaFestival(form.getFestivalId());
		Film film = caricaFilm(form.getFilmId());
		Sala sala = caricaSala(form.getSalaId());

		verificaProgrammazione(festival, film, sala, form.getData(), form.getOra(), id);

		// Si tolgono le associazioni vecchie e si mettono le nuove (se festival, film o sala sono cambiati)
		proiezione.getFestival().getProiezioni().remove(proiezione);
		proiezione.getFilm().getProiezioni().remove(proiezione);
		proiezione.getSala().getProiezioni().remove(proiezione);

		proiezione.setData(form.getData());
		proiezione.setOra(form.getOra());
		proiezione.setFestival(festival);
		proiezione.setFilm(film);
		proiezione.setSala(sala);

		festival.getProiezioni().add(proiezione);
		film.getProiezioni().add(proiezione);
		sala.getProiezioni().add(proiezione);

		return this.proiezioneRepository.save(proiezione);
	}

	// ANNULLAMENTO: la proiezione non viene cancellata dal database ma passa a CANCELLED.
	// Cosi' si conserva lo storico e la sala torna libera (le CANCELLED non contano nel controllo).
	@Transactional
	public Proiezione annulla(Long id) {
		Proiezione proiezione = this.proiezioneRepository.findById(id)
				.orElseThrow(() -> new ProiezioneNotFoundException(id));
		if (proiezione.getStato() != Stato.SCHEDULED) {
			throw new ProgrammazioneNonValidaException("Si possono annullare solo le proiezioni programmate");
		}
		proiezione.setStato(Stato.CANCELLED);
		return this.proiezioneRepository.save(proiezione);
	}

	private Festival caricaFestival(Long id) {
		return this.festivalRepository.findById(id).orElseThrow(() -> new FestivalNotFoundException(id));
	}

	private Film caricaFilm(Long id) {
		return this.filmRepository.findById(id).orElseThrow(() -> new FilmNotFoundException(id));
	}

	private Sala caricaSala(Long id) {
		return this.salaRepository.findById(id).orElseThrow(() -> new SalaNotFoundException(id));
	}

	// Controlli di consistenza comuni a programmazione e modifica.
	// idDaEscludere: nella modifica e' l'id della proiezione stessa (null nell'inserimento).
	private void verificaProgrammazione(Festival festival, Film film, Sala sala, LocalDate data, LocalTime ora,
			Long idDaEscludere) {
		// il film deve partecipare al festival scelto
		boolean filmNelFestival = film.getFestival().stream()
				.anyMatch(f -> f.getId().equals(festival.getId()));
		if (!filmNelFestival) {
			throw new ProgrammazioneNonValidaException("Il film scelto non partecipa a questo festival");
		}

		// la data deve cadere nel periodo del festival
		if (data.isBefore(festival.getDataInizio()) || data.isAfter(festival.getDataFine())) {
			throw new ProgrammazioneNonValidaException(
					"La data deve essere compresa tra l inizio e la fine del festival ("
							+ festival.getDataInizio() + " - " + festival.getDataFine() + ")");
		}

		// la sala deve essere libera. Intervallo = [inizio, inizio + durata del film).
		// Due intervalli si sovrappongono se inizioNuova < fineEsistente E inizioEsistente < fineNuova.
		LocalDateTime inizio = data.atTime(ora);
		LocalDateTime fine = inizio.plusMinutes(film.getDurata());
		List<Proiezione> vicine = this.proiezioneRepository.findBySalaIdAndDataBetween(
				sala.getId(), data.minusDays(1), data.plusDays(1));
		for (Proiezione p : vicine) {
			if (p.getStato() == Stato.CANCELLED) {
				continue; // una proiezione cancellata non occupa la sala
			}
			if (idDaEscludere != null && p.getId().equals(idDaEscludere)) {
				continue; // nella modifica non si confronta la proiezione con se stessa
			}
			LocalDateTime pInizio = p.getData().atTime(p.getOra());
			LocalDateTime pFine = pInizio.plusMinutes(p.getFilm().getDurata());
			if (inizio.isBefore(pFine) && pInizio.isBefore(fine)) {
				throw new ProgrammazioneNonValidaException("La sala è già occupata da \"" + p.getFilm().getTitolo()
						+ "\" il " + p.getData() + " dalle " + pInizio.toLocalTime() + " alle " + pFine.toLocalTime());
			}
		}
	}
}
