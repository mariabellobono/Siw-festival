package it.uniroma3.siw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import it.uniroma3.siw.service.FilmService;

@Controller
public class FilmController {
	private final FilmService  filmService;
	
	public FilmController(FilmService filmservice) {
		this.filmService = filmservice;
	}
	
	@GetMapping("/films")
	public String tuttiFilms(Model model) {
		model.addAttribute("films", filmService.findAll());
		return "films/tuttifilms";
		
	}
	@GetMapping("/films/{id}")
	public String singoloFilm(@PathVariable("id")Long id,Model model) {
		model.addAttribute("film", filmService.findById(id));
		return "films/film";
		
		
	}
	
}
