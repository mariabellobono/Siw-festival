package it.uniroma3.siw.rest;

import java.net.URI;
import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import it.uniroma3.siw.dto.ApiDto.RecensioneDto;
import it.uniroma3.siw.dto.ApiDto.RecensioneRequest;
import it.uniroma3.siw.model.Recensione;
import it.uniroma3.siw.service.RecensioneService;
import jakarta.validation.Valid;

// API delle RECENSIONI. Leggere: tutti. Scrivere: serve il login (SecurityConfiguration)
// e si possono modificare/eliminare solo le PROPRIE recensioni (controllo qui sotto -> 403).
@RestController
@RequestMapping("/api")
public class RecensioneRestController {

	private final RecensioneService recensioneService;

	public RecensioneRestController(RecensioneService recensioneService) {
		this.recensioneService = recensioneService;
	}

	// GET /api/films/{filmId}/reviews  ->  200 con le recensioni, 404 se il film non esiste
	@GetMapping("/films/{filmId}/reviews")
	public List<RecensioneDto> elenco(@PathVariable("filmId") Long filmId) {
		return recensioneService.delFilm(filmId).stream().map(RestMapper::recensione).toList();
	}

	// POST /api/films/{filmId}/reviews  ->  201, 400, 401 (non collegato), 404 film, 409 recensione gia' scritta
	// L'autore NON arriva dal corpo della richiesta: e' l'utente collegato (altrimenti si potrebbe scrivere a nome di altri).
	@PostMapping("/films/{filmId}/reviews")
	public ResponseEntity<RecensioneDto> crea(@PathVariable("filmId") Long filmId,
			@Valid @RequestBody RecensioneRequest richiesta, Authentication authentication) {
		Recensione recensione = recensioneService.inserisci(filmId, authentication.getName(), daRichiesta(richiesta));
		return ResponseEntity.created(URI.create("/api/reviews/" + recensione.getId()))
				.body(RestMapper.recensione(recensione));
	}

	// PUT /api/reviews/{id}  ->  200, 400, 401, 403 (non e' tua), 404
	@PutMapping("/reviews/{id}")
	public RecensioneDto modifica(@PathVariable("id") Long id, @Valid @RequestBody RecensioneRequest richiesta,
			Authentication authentication) {
		controllaAutore(id, authentication);
		return RestMapper
				.recensione(recensioneService.modifica(id, authentication.getName(), daRichiesta(richiesta)));
	}

	// DELETE /api/reviews/{id}  ->  204, 401, 403 (non e' tua), 404
	@DeleteMapping("/reviews/{id}")
	public ResponseEntity<Void> elimina(@PathVariable("id") Long id, Authentication authentication) {
		controllaAutore(id, authentication);
		recensioneService.elimina(id, authentication.getName());
		return ResponseEntity.noContent().build();
	}

	// 404 se la recensione non esiste, 403 se e' di un altro utente
	private void controllaAutore(Long id, Authentication authentication) {
		Recensione recensione = recensioneService.findById(id);
		if (!recensioneService.isAutore(recensione, authentication.getName())) {
			throw new AccessDeniedException("Puoi modificare o eliminare solo le tue recensioni");
		}
	}

	private Recensione daRichiesta(RecensioneRequest r) {
		Recensione dati = new Recensione();
		dati.setTesto(r.testo().trim());
		dati.setVoto(r.voto());
		return dati;
	}
}
