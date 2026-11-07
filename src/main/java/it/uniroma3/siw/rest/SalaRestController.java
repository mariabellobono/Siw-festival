package it.uniroma3.siw.rest;

import java.net.URI;
import java.util.ArrayList;
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

import it.uniroma3.siw.dto.ApiDto.SalaDto;
import it.uniroma3.siw.dto.ApiDto.SalaRequest;
import it.uniroma3.siw.model.Sala;
import it.uniroma3.siw.service.SalaService;
import jakarta.validation.Valid;

// API delle SALE: GET per tutti, POST/PUT/DELETE solo ADMIN.
@RestController
@RequestMapping("/api/sale")
public class SalaRestController {

	private final SalaService salaService;

	public SalaRestController(SalaService salaService) {
		this.salaService = salaService;
	}

	// GET /api/sale  ->  200
	@GetMapping
	public List<SalaDto> elenco() {
		List<SalaDto> risultato = new ArrayList<>();
		for (Sala s : salaService.findAll()) {
			risultato.add(RestMapper.sala(s));
		}
		return risultato;
	}

	// GET /api/sale/{id}  ->  200 oppure 404
	@GetMapping("/{id}")
	public SalaDto dettaglio(@PathVariable("id") Long id) {
		return RestMapper.sala(salaService.findById(id));
	}

	// POST /api/sale  ->  201 + Location, 400
	@PostMapping
	public ResponseEntity<SalaDto> crea(@Valid @RequestBody SalaRequest richiesta) {
		Sala salvata = salaService.save(daRichiesta(richiesta));
		return ResponseEntity.created(URI.create("/api/sale/" + salvata.getId())).body(RestMapper.sala(salvata));
	}

	// PUT /api/sale/{id}  ->  200, 400, 404
	@PutMapping("/{id}")
	public SalaDto aggiorna(@PathVariable("id") Long id, @Valid @RequestBody SalaRequest richiesta) {
		return RestMapper.sala(salaService.aggiorna(id, daRichiesta(richiesta)));
	}

	// DELETE /api/sale/{id}  ->  204, 404, 409 se la sala ha proiezioni
	@DeleteMapping("/{id}")
	public ResponseEntity<Void> elimina(@PathVariable("id") Long id) {
		salaService.elimina(id);
		return ResponseEntity.noContent().build();
	}

	private Sala daRichiesta(SalaRequest r) {
		Sala sala = new Sala();
		sala.setNome(r.nome().trim());
		sala.setIndirizzo(r.indirizzo().trim());
		sala.setCapienza(r.capienza());
		return sala;
	}
}
