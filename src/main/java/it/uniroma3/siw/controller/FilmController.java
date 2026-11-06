package it.uniroma3.siw.controller;

import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import it.uniroma3.siw.service.FilmService;
import it.uniroma3.siw.service.RecensioneService;

@Controller
public class FilmController {
	private final FilmService  filmService;
	private final RecensioneService recensioneService;
	
	public FilmController(FilmService filmservice, RecensioneService recensioneService) {
		this.filmService = filmservice;
		this.recensioneService = recensioneService;
	}
	
	@GetMapping("/films")
	public String tuttiFilms(@RequestParam(name = "regista", required = false) String regista, Model model) {
		// Con ?regista=Nome si mostrano solo i film di quel regista, altrimenti tutti
		if (regista != null && !regista.isBlank()) {
			model.addAttribute("films", filmService.findByRegista(regista));
			model.addAttribute("filtroRegista", regista);
		} else {
			model.addAttribute("films", filmService.findAll());
		}
		return "films/tuttifilms";
		
	}
	@GetMapping("/films/{id}")
	public String singoloFilm(@PathVariable("id")Long id, Authentication authentication, Model model) {
		model.addAttribute("film", filmService.findById(id));
		// La recensione dell'utente collegato per questo film (null se anonimo o se non ne ha scritta una):
		// serve alla pagina per mostrare "Scrivi una recensione" oppure "Modifica/Elimina" sulla sua.
		boolean collegato = authentication != null && !(authentication instanceof AnonymousAuthenticationToken);
		model.addAttribute("miaRecensione", collegato ? recensioneService.trovaDelloUtente(id, authentication.getName()) : null);
		return "films/film";
		
		
	}
	
}
