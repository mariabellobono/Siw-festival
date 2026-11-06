package it.uniroma3.siw.controller;

import org.springframework.dao.ConcurrencyFailureException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import it.uniroma3.siw.dto.ProiezioneForm;
import it.uniroma3.siw.exception.FestivalNotFoundException;
import it.uniroma3.siw.exception.FilmNotFoundException;
import it.uniroma3.siw.exception.ProgrammazioneNonValidaException;
import it.uniroma3.siw.exception.SalaNotFoundException;
import it.uniroma3.siw.model.Proiezione;
import it.uniroma3.siw.service.FestivalService;
import it.uniroma3.siw.service.FilmService;
import it.uniroma3.siw.service.ProiezioneService;
import it.uniroma3.siw.service.SalaService;
import jakarta.validation.Valid;

@Controller
public class AdminProiezioneController {
	private final ProiezioneService proiezioneService;
	private final FestivalService festivalService;
	private final FilmService filmService;
	private final SalaService salaService;

	public AdminProiezioneController(ProiezioneService proiezioneService, FestivalService festivalService,
			FilmService filmService, SalaService salaService) {
		this.proiezioneService = proiezioneService;
		this.festivalService = festivalService;
		this.filmService = filmService;
		this.salaService = salaService;
	}

	// ---------- PROGRAMMAZIONE ----------
	@GetMapping("/admin/proiezioni/new")
	public String programmaProiezione(Model model) {
		model.addAttribute("proiezioneForm", new ProiezioneForm());
		caricaTendine(model);
		return "admin/proiezione-form";
	}

	@PostMapping("/admin/proiezioni")
	public String salvaProiezione(@Valid @ModelAttribute("proiezioneForm") ProiezioneForm form,
			BindingResult errori, Model model, RedirectAttributes redirectAttributes) {
		if (!errori.hasErrors()) {
			try {
				Proiezione proiezione = this.proiezioneService.programma(form);
				redirectAttributes.addFlashAttribute("messaggio", "Inserimento effettuato");
				return "redirect:/proiezioni/" + proiezione.getId();
			} catch (ProgrammazioneNonValidaException e) {
				errori.reject("programmazioneNonValida", e.getMessage());
			} catch (ConcurrencyFailureException e) {
				errori.reject("accessoSimultaneo", "Un altro amministratore sta modificando la stessa sala: riprova");
			} catch (FestivalNotFoundException | FilmNotFoundException | SalaNotFoundException e) {
				errori.reject("datiNonValidi", e.getMessage());
			}
		}
		caricaTendine(model);
		return "admin/proiezione-form";
	}

	// ---------- MODIFICA ----------
	@GetMapping("/admin/proiezioni/{id}/edit")
	public String modificaProiezione(@PathVariable("id") Long id, Model model) {
		Proiezione p = this.proiezioneService.findById(id);
		ProiezioneForm form = new ProiezioneForm();
		form.setFestivalId(p.getFestival().getId());
		form.setFilmId(p.getFilm().getId());
		form.setSalaId(p.getSala().getId());
		form.setData(p.getData());
		form.setOra(p.getOra());
		model.addAttribute("proiezioneForm", form);
		model.addAttribute("proiezioneId", id);
		caricaTendine(model);
		return "admin/proiezione-form";
	}

	@PostMapping("/admin/proiezioni/{id}")
	public String aggiornaProiezione(@PathVariable("id") Long id,
			@Valid @ModelAttribute("proiezioneForm") ProiezioneForm form,
			BindingResult errori, Model model, RedirectAttributes redirectAttributes) {
		if (!errori.hasErrors()) {
			try {
				this.proiezioneService.modifica(id, form);
				redirectAttributes.addFlashAttribute("messaggio", "Modifica effettuata");
				return "redirect:/proiezioni/" + id;
			} catch (ProgrammazioneNonValidaException e) {
				errori.reject("programmazioneNonValida", e.getMessage());
			} catch (ConcurrencyFailureException e) {
				errori.reject("accessoSimultaneo", "Un altro amministratore sta modificando la stessa sala: riprova");
			} catch (FestivalNotFoundException | FilmNotFoundException | SalaNotFoundException e) {
				errori.reject("datiNonValidi", e.getMessage());
			}
		}
		model.addAttribute("proiezioneId", id);
		caricaTendine(model);
		return "admin/proiezione-form";
	}

	// ---------- ANNULLAMENTO ----------
	@PostMapping("/admin/proiezioni/{id}/annulla")
	public String annullaProiezione(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
		try {
			this.proiezioneService.annulla(id);
			redirectAttributes.addFlashAttribute("messaggio", "Proiezione annullata");
		} catch (ProgrammazioneNonValidaException e) {
			redirectAttributes.addFlashAttribute("messaggio", e.getMessage());
		}
		return "redirect:/proiezioni/" + id;
	}

	// Le tendine vanno ricaricate ogni volta che si mostra il modulo (anche dopo un errore)
	private void caricaTendine(Model model) {
		model.addAttribute("festivals", this.festivalService.findAll());
		model.addAttribute("films", this.filmService.findAll());
		model.addAttribute("sale", this.salaService.findAll());
	}
}
