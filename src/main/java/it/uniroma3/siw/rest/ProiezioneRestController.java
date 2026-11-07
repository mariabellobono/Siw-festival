package it.uniroma3.siw.rest;

import java.net.URI;
import java.time.LocalDate;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import it.uniroma3.siw.dto.ProiezioneForm;
import it.uniroma3.siw.dto.ApiDto.ProiezioneDto;
import it.uniroma3.siw.model.Proiezione;
import it.uniroma3.siw.service.ProiezioneService;
import jakarta.validation.Valid;

// API delle PROIEZIONI. Le regole (film nel festival, data nel periodo, sala libera) sono quelle del service,
// le stesse del sito: violarle da' 409. Il corpo di POST/PUT riusa ProiezioneForm (festivalId, filmId, salaId, data, ora).
@RestController
@RequestMapping("/api/screenings")
public class ProiezioneRestController {

	private final ProiezioneService proiezioneService;

	public ProiezioneRestController(ProiezioneService proiezioneService) {
		this.proiezioneService = proiezioneService;
	}

	// GET /api/screenings            ->  tutte
	// GET /api/screenings?data=2026-09-03  ->  solo quelle del giorno
	@GetMapping
	public List<ProiezioneDto> elenco(
			@RequestParam(name = "data", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate data) {
		List<Proiezione> proiezioni = (data == null) ? proiezioneService.findAllConDettagli()
				: proiezioneService.findByData(data);
		return proiezioni.stream().map(RestMapper::proiezione).toList();
	}

	// GET /api/screenings/{id}  ->  200 oppure 404
	@GetMapping("/{id}")
	public ProiezioneDto dettaglio(@PathVariable("id") Long id) {
		return RestMapper.proiezione(proiezioneService.findById(id));
	}

	// POST /api/screenings  ->  201, 400, 404 (festival/film/sala inesistenti), 409 (regole violate)
	@PostMapping
	public ResponseEntity<ProiezioneDto> programma(@Valid @RequestBody ProiezioneForm richiesta) {
		Proiezione creata = proiezioneService.programma(richiesta);
		return ResponseEntity.created(URI.create("/api/screenings/" + creata.getId()))
				.body(RestMapper.proiezione(creata));
	}

	// PUT /api/screenings/{id}  ->  200, 400, 404, 409
	@PutMapping("/{id}")
	public ProiezioneDto modifica(@PathVariable("id") Long id, @Valid @RequestBody ProiezioneForm richiesta) {
		return RestMapper.proiezione(proiezioneService.modifica(id, richiesta));
	}

	// DELETE /api/screenings/{id}  ->  204. Scelta nostra: "eliminare" = ANNULLARE (stato CANCELLED),
	// la riga resta nel database come storico. 404 se non esiste, 409 se non e' piu' programmata.
	@DeleteMapping("/{id}")
	public ResponseEntity<Void> annulla(@PathVariable("id") Long id) {
		proiezioneService.annulla(id);
		return ResponseEntity.noContent().build();
	}
}
