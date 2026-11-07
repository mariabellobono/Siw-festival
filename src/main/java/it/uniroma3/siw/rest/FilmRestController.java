package it.uniroma3.siw.rest;

import java.net.URI;
import java.util.List;

import org.springframework.data.domain.Page;
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

import it.uniroma3.siw.dto.ApiDto.FilmDettaglioDto;
import it.uniroma3.siw.dto.ApiDto.FilmDto;
import it.uniroma3.siw.dto.ApiDto.FilmRequest;
import it.uniroma3.siw.dto.ApiDto.PaginaDto;
import it.uniroma3.siw.exception.OperazioneNonConsentitaException;
import it.uniroma3.siw.model.Film;
import it.uniroma3.siw.service.FilmService;
import it.uniroma3.siw.service.RecensioneService;
import jakarta.validation.Valid;

// API dei FILM. @RestController = @Controller + @ResponseBody: il valore restituito diventa JSON
// (non il nome di una pagina). Chi puo' fare cosa e' deciso in SecurityConfiguration:
// GET per tutti, POST/PUT/DELETE solo ADMIN.
@RestController
@RequestMapping("/api/films")
public class FilmRestController {

	private final FilmService filmService;
	private final RecensioneService recensioneService;

	public FilmRestController(FilmService filmService, RecensioneService recensioneService) {
		this.filmService = filmService;
		this.recensioneService = recensioneService;
	}

	// GET /api/films?titolo=&genere=&regista=&page=0&size=10  ->  200 con una pagina di film
	@GetMapping
	public PaginaDto<FilmDto> cerca(@RequestParam(name = "titolo", required = false) String titolo,
			@RequestParam(name = "genere", required = false) String genere,
			@RequestParam(name = "regista", required = false) String regista,
			@RequestParam(name = "page", defaultValue = "0") int page,
			@RequestParam(name = "size", defaultValue = "10") int size) {
		Page<Film> risultato = filmService.cerca(titolo, genere, regista, page, size);
		List<FilmDto> contenuto = risultato.getContent().stream().map(RestMapper::film).toList();
		return new PaginaDto<>(contenuto, risultato.getNumber(), risultato.getSize(), risultato.getTotalElements(),
				risultato.getTotalPages());
	}

	// GET /api/films/generi  ->  200 con la lista dei generi (per il menu di ricerca)
	@GetMapping("/generi")
	public List<String> generi() {
		return filmService.generi();
	}

	// GET /api/films/{id}  ->  200 con il dettaglio (media voti, festival) oppure 404
	@GetMapping("/{id}")
	public FilmDettaglioDto dettaglio(@PathVariable("id") Long id) {
		Film film = filmService.findDettaglio(id);
		return RestMapper.filmDettaglio(film, recensioneService.mediaVoti(id), recensioneService.numero(id));
	}

	// POST /api/films  ->  201 Created + header Location, 400 dati non validi, 409 film gia' esistente
	@PostMapping
	public ResponseEntity<FilmDto> crea(@Valid @RequestBody FilmRequest richiesta) {
		if (filmService.existsByTitoloAndAnno(richiesta.titolo().trim(), richiesta.anno())) {
			throw new OperazioneNonConsentitaException("Film già esistente");
		}
		Film salvato = filmService.save(daRichiesta(richiesta));
		return ResponseEntity.created(URI.create("/api/films/" + salvato.getId())).body(RestMapper.film(salvato));
	}

	// PUT /api/films/{id}  ->  200 col film aggiornato, 404, 400, 409
	@PutMapping("/{id}")
	public FilmDto aggiorna(@PathVariable("id") Long id, @Valid @RequestBody FilmRequest richiesta) {
		filmService.findById(id); // 404 se non esiste, prima di ogni altro controllo
		if (filmService.existsByTitoloAndAnnoAndIdNot(richiesta.titolo().trim(), richiesta.anno(), id)) {
			throw new OperazioneNonConsentitaException("Film già esistente");
		}
		return RestMapper.film(filmService.aggiorna(id, daRichiesta(richiesta)));
	}

	// DELETE /api/films/{id}  ->  204 No Content (nessun corpo), 404, 409 se il film e' ancora usato
	@DeleteMapping("/{id}")
	public ResponseEntity<Void> elimina(@PathVariable("id") Long id) {
		filmService.elimina(id);
		return ResponseEntity.noContent().build();
	}

	// Il service lavora con le entita': dal DTO di richiesta si costruisce un Film "di appoggio"
	private Film daRichiesta(FilmRequest r) {
		Film film = new Film();
		film.setTitolo(r.titolo().trim());
		film.setAnno(r.anno());
		film.setDurata(r.durata());
		film.setGenere(r.genere().trim());
		film.setPaeseProduzione(r.paeseProduzione().trim());
		film.setRegista(r.regista().trim());
		return film;
	}
}
