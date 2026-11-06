package it.uniroma3.siw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
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
			errori.rejectValue("titolo", "duplicato", "Film già esistente");
		}
		if(errori.hasErrors()) {
			return "admin/film-form";
		}
		film.setId(null);
		filmService.save(film);

		redirectAttributes.addFlashAttribute("messaggio", "Inserimento effettuato");
		return "redirect:/films/" + film.getId();
	}

	// MODIFICA: stesso modulo dell'inserimento, ma gia' compilato con i dati del film
	@GetMapping("/admin/films/{id}/edit")
	public String modificaFilm(@PathVariable("id") Long id, Model model) {
		model.addAttribute("film", filmService.findById(id));
		return "admin/film-form";
	}

	@PostMapping("/admin/films/{id}")
	public String aggiornaFilm(@PathVariable("id") Long id, @Valid @ModelAttribute("film") Film film,
			BindingResult errori, RedirectAttributes redirectAttributes) {
		film.setId(id); // l'id arriva dall'indirizzo, non dal modulo; serve anche al modulo se si torna indietro con errori
		if(!errori.hasErrors() && filmService.existsByTitoloAndAnnoAndIdNot(film.getTitolo(), film.getAnno(), id)) {
			errori.rejectValue("titolo", "duplicato", "Film già esistente");
		}
		if(errori.hasErrors()) {
			return "admin/film-form";
		}
		filmService.aggiorna(id, film);

		redirectAttributes.addFlashAttribute("messaggio", "Modifica effettuata");
		return "redirect:/films/" + id;
	}
}
