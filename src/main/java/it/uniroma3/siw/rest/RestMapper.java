package it.uniroma3.siw.rest;

import java.util.List;

import it.uniroma3.siw.dto.ApiDto.FestivalDto;
import it.uniroma3.siw.dto.ApiDto.FestivalSintesiDto;
import it.uniroma3.siw.dto.ApiDto.FilmDettaglioDto;
import it.uniroma3.siw.dto.ApiDto.FilmDto;
import it.uniroma3.siw.dto.ApiDto.ProiezioneDto;
import it.uniroma3.siw.dto.ApiDto.RecensioneDto;
import it.uniroma3.siw.dto.ApiDto.SalaDto;
import it.uniroma3.siw.model.Festival;
import it.uniroma3.siw.model.Film;
import it.uniroma3.siw.model.Proiezione;
import it.uniroma3.siw.model.Recensione;
import it.uniroma3.siw.model.Sala;

// Trasforma le ENTITA' in DTO (e quindi in JSON). Qui si decide cosa mostrare all'esterno.
// Regola: si leggono solo campi semplici e relazioni ManyToOne (gia' caricate); le liste LAZY
// (film.festival, festival.films...) le carica il service/repository nella sua transazione.
final class RestMapper {

	private RestMapper() {
	}

	static FilmDto film(Film f) {
		return new FilmDto(f.getId(), f.getTitolo(), f.getAnno(), f.getDurata(), f.getGenere(),
				f.getPaeseProduzione(), f.getRegista());
	}

	// il film deve arrivare con i festival gia' caricati (FilmService.findDettaglio)
	static FilmDettaglioDto filmDettaglio(Film f, Double mediaVoti, long numeroRecensioni) {
		List<FestivalSintesiDto> festival = f.getFestival().stream()
				.map(x -> new FestivalSintesiDto(x.getId(), x.getNome(), x.getAnno())).toList();
		Double media = mediaVoti == null ? null : Math.round(mediaVoti * 10.0) / 10.0; // 1 decimale
		return new FilmDettaglioDto(f.getId(), f.getTitolo(), f.getAnno(), f.getDurata(), f.getGenere(),
				f.getPaeseProduzione(), f.getRegista(), media, numeroRecensioni, festival);
	}

	static FestivalDto festival(Festival f) {
		return new FestivalDto(f.getId(), f.getNome(), f.getAnno(), f.getCitta(), f.getDataInizio(),
				f.getDataFine(), f.getDescrizione());
	}

	static SalaDto sala(Sala s) {
		return new SalaDto(s.getId(), s.getNome(), s.getIndirizzo(), s.getCapienza());
	}

	static ProiezioneDto proiezione(Proiezione p) {
		return new ProiezioneDto(p.getId(), p.getData(), p.getOra(), p.getStato() == null ? null : p.getStato().name(),
				p.getFestival().getId(), p.getFestival().getNome(), p.getFilm().getId(), p.getFilm().getTitolo(),
				p.getSala().getId(), p.getSala().getNome());
	}

	static RecensioneDto recensione(Recensione r) {
		return new RecensioneDto(r.getId(), r.getTesto(), r.getVoto(), r.getData(), r.getFilm().getId(),
				r.getUtente().getId(), r.getUtente().getNome() + " " + r.getUtente().getCognome());
	}
}
