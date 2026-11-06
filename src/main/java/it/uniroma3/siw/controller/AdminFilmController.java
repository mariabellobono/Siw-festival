package it.uniroma3.siw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	public String salvaFilm(@Valid @ModelAttribute("film") Film film, BindingResult errori, RedirectAttributes redirectAttributes) {
		if(!errori.hasErrors() && filmService.existsByTitoloAndAnno(film.getTitolo(), film.getAnno())) {
			errori.rejectValue("titolo", "duplicato","Film già esistente");
		}
		if(errori.hasErrors()) {
			return "admin/film-form";
		}
		film.setId(null);
		filmService.save(film);
		
		redirectAttributes.addFlashAttribute("messaggio", "Inserimento effettuato");
		return "redirect:/films/" + film.getId();
		
	}
	
	
	
	
	

}
