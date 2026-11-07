package it.uniroma3.siw.rest;

import java.net.URI;
import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import it.uniroma3.siw.dto.ApiDto.FestivalDto;
import it.uniroma3.siw.dto.ApiDto.FestivalRequest;
import it.uniroma3.siw.dto.ApiDto.FilmDto;
import it.uniroma3.siw.dto.ApiDto.ProiezioneDto;
import it.uniroma3.siw.model.Festival;
import it.uniroma3.siw.service.FestivalService;
import it.uniroma3.siw.service.ProiezioneService;
import jakarta.validation.Valid;

// API dei FESTIVAL: GET per tutti, POST/PUT/DELETE solo ADMIN.
@RestController
@RequestMapping("/api/festivals")
public class FestivalRestController {

	private final FestivalService festivalService;
	private final ProiezioneService proiezioneService;

	public FestivalRestController(FestivalService festivalService, ProiezioneService proiezioneService) {
		this.festivalService = festivalService;
		this.proiezioneService = proiezioneService;
	}

	// GET /api/festivals  ->  200
	@GetMapping
	public List<FestivalDto> elenco() {
		List<FestivalDto> risultato = new java.util.ArrayList<>();
		for (Festival f : festivalService.findAll()) {
			risultato.add(RestMapper.festival(f));
		}
		return risultato;
	}

	// GET /api/festivals/{id}  ->  200 oppure 404
	@GetMapping("/{id}")
	public FestivalDto dettaglio(@PathVariable("id") Long id) {
		return RestMapper.festival(festivalService.findById(id));
	}

	// GET /api/festivals/{id}/movies  ->  film che partecipano al festival
	@GetMapping("/{id}/movies")
	public List<FilmDto> film(@PathVariable("id") Long id) {
		return festivalService.filmDelFestival(id).stream().map(RestMapper::film).toList();
	}

	// GET /api/festivals/{id}/screenings  ->  programma delle proiezioni del festival
	@GetMapping("/{id}/screenings")
	public List<ProiezioneDto> programma(@PathVariable("id") Long id) {
		return proiezioneService.findByFestival(id).stream().map(RestMapper::proiezione).toList();
	}

	// POST /api/festivals  ->  201 + Location, 400
	@PostMapping
	public ResponseEntity<FestivalDto> crea(@Valid @RequestBody FestivalRequest richiesta) {
		Festival salvato = festivalService.save(daRichiesta(richiesta));
		return ResponseEntity.created(URI.create("/api/festivals/" + salvato.getId()))
				.body(RestMapper.festival(salvato));
	}

	// PUT /api/festivals/{id}  ->  200, 400, 404
	@PutMapping("/{id}")
	public FestivalDto aggiorna(@PathVariable("id") Long id, @Valid @RequestBody FestivalRequest richiesta) {
		return RestMapper.festival(festivalService.aggiorna(id, daRichiesta(richiesta)));
	}

	// DELETE /api/festivals/{id}  ->  204, 404, 409 se ha ancora film o proiezioni
	@DeleteMapping("/{id}")
	public ResponseEntity<Void> elimina(@PathVariable("id") Long id) {
		festivalService.elimina(id);
		return ResponseEntity.noContent().build();
	}

	// POST /api/festivals/{id}/movies/{filmId}  ->  204: il film entra nel festival (409 se c'e' gia')
	@PostMapping("/{id}/movies/{filmId}")
	public ResponseEntity<Void> aggiungiFilm(@PathVariable("id") Long id, @PathVariable("filmId") Long filmId) {
		festivalService.aggiungiFilm(id, filmId);
		return ResponseEntity.noContent().build();
	}

	// DELETE /api/festivals/{id}/movies/{filmId}  ->  204: il film esce dal festival (409 se ha proiezioni programmate)
	@DeleteMapping("/{id}/movies/{filmId}")
	public ResponseEntity<Void> rimuoviFilm(@PathVariable("id") Long id, @PathVariable("filmId") Long filmId) {
		festivalService.rimuoviFilm(id, filmId);
		return ResponseEntity.noContent().build();
	}

	private Festival daRichiesta(FestivalRequest r) {
		// Regola di coerenza (la stessa del modulo sul sito). IllegalArgumentException -> 400 (RestExceptionHandler)
		if (r.dataFine().isBefore(r.dataInizio())) {
			throw new IllegalArgumentException("La data di fine non può precedere la data di inizio");
		}
		Festival festival = new Festival();
		festival.setNome(r.nome().trim());
		festival.setAnno(r.anno());
		festival.setCitta(r.citta().trim());
		festival.setDataInizio(r.dataInizio());
		festival.setDataFine(r.dataFine());
		festival.setDescrizione(r.descrizione());
		return festival;
	}
}
