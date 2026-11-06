package it.uniroma3.siw.controller;

import java.lang.ProcessBuilder.Redirect;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import it.uniroma3.siw.model.Film;
import it.uniroma3.siw.service.FilmService;
import jakarta.validation.Valid;

@Controller
public class AdminFilmController {
	private final FilmService filmService;
	
	public AdminFilmController(FilmService filmService) {
		this.filmService = filmService;
	}
	@GetMapping("/admin/films/new")
	public String inserisciFilm(Model model) {
		model.addAttribute("film", new Film());
	    return "admin/film-form";
	}
	
	@PostMapping("/admin/films")
	public String salvaFilm(@Valid @ModelAttribute("film") Film film, BindingResult errori) {
		if(filmService.existsByTitoloAndAnno(film.getTitolo() , film.getAnno())) {
			errori.rejectValue("titolo", "duplicato","film gia' inserito");
		}
		if(errori.hasErrors()) {
			return "admin/film-form";
		}
		titolo.setId(null);
		anno.se
		
		filmService.save(film);
		
		return "redirect/admin/films" + film.getId();
		
	}
	
	
	
	
	

}
