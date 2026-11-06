package it.uniroma3.siw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import it.uniroma3.siw.exception.OperazioneNonConsentitaException;
import it.uniroma3.siw.model.Festival;
import it.uniroma3.siw.service.FestivalService;
import jakarta.validation.Valid;

@Controller
public class AdminFestivalController {
	private final FestivalService festivalService;

	public AdminFestivalController(FestivalService festivalService) {
		this.festivalService = festivalService;
	}

	@GetMapping("/admin/festivals/new")
	public String inserisciFestival(Model model) {
		model.addAttribute("festival", new Festival());
		return "admin/festival-form";
	}

	@PostMapping("/admin/festivals")
	public String salvaFestival(@Valid @ModelAttribute("festival") Festival festival, BindingResult errori, RedirectAttributes redirectAttributes) {
		// Controllo sulle date solo se entrambe sono compilate e valide (altrimenti sarebbero null)
		if(!errori.hasErrors() && festival.getDataFine().isBefore(festival.getDataInizio())) {
			errori.rejectValue("dataFine", "dataNonValida", "La data di fine non può essere prima di quella di inizio");
		}
		if(errori.hasErrors()) {
			return "admin/festival-form";
		}
		festival.setId(null);
		festivalService.save(festival);

		redirectAttributes.addFlashAttribute("messaggio", "Inserimento effettuato");
		return "redirect:/festivals/" + festival.getId();
	}

	// ---------- FILM DEL FESTIVAL: associazione e rimozione ----------
	@GetMapping("/admin/festivals/{id}/films")
	public String gestisciFilm(@PathVariable("id") Long id, Model model) {
		model.addAttribute("festival", festivalService.findById(id));
		model.addAttribute("filmDisponibili", festivalService.filmNonPresenti(id));
		return "admin/festival-film";
	}

	@PostMapping("/admin/festivals/{id}/films")
	public String aggiungiFilm(@PathVariable("id") Long id, @RequestParam("filmId") Long filmId,
			RedirectAttributes redirectAttributes) {
		try {
			festivalService.aggiungiFilm(id, filmId);
			redirectAttributes.addFlashAttribute("messaggio", "Film aggiunto al festival");
		} catch (OperazioneNonConsentitaException e) {
			redirectAttributes.addFlashAttribute("messaggio", e.getMessage());
		}
		return "redirect:/admin/festivals/" + id + "/films";
	}

	@PostMapping("/admin/festivals/{id}/films/{filmId}/rimuovi")
	public String rimuoviFilm(@PathVariable("id") Long id, @PathVariable("filmId") Long filmId,
			RedirectAttributes redirectAttributes) {
		try {
			festivalService.rimuoviFilm(id, filmId);
			redirectAttributes.addFlashAttribute("messaggio", "Film rimosso dal festival");
		} catch (OperazioneNonConsentitaException e) {
			redirectAttributes.addFlashAttribute("messaggio", e.getMessage());
		}
		return "redirect:/admin/festivals/" + id + "/films";
	}
}
