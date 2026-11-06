package it.uniroma3.siw.controller;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import it.uniroma3.siw.exception.OperazioneNonConsentitaException;
import it.uniroma3.siw.model.Recensione;
import it.uniroma3.siw.service.FilmService;
import it.uniroma3.siw.service.RecensioneService;
import jakarta.validation.Valid;

// Tutti gli indirizzi /recensioni/** richiedono il login (regola anyRequest().authenticated() in SecurityConfiguration).
// L'utente non arriva mai dal modulo: si ricava dal login (authentication.getName()).
@Controller
public class RecensioneController {
	private final RecensioneService recensioneService;
	private final FilmService filmService;

	public RecensioneController(RecensioneService recensioneService, FilmService filmService) {
		this.recensioneService = recensioneService;
		this.filmService = filmService;
	}

	// ---------- INSERIMENTO ----------
	@GetMapping("/recensioni/film/{filmId}/new")
	public String nuova(@PathVariable("filmId") Long filmId, Authentication authentication, Model model,
			RedirectAttributes redirectAttributes) {
		if (this.recensioneService.trovaDelloUtente(filmId, authentication.getName()) != null) {
			redirectAttributes.addFlashAttribute("messaggio", "Hai già scritto una recensione per questo film");
			return "redirect:/films/" + filmId;
		}
		model.addAttribute("film", this.filmService.findById(filmId));
		model.addAttribute("recensione", new Recensione());
		return "recensioni/recensione-form";
	}

	@PostMapping("/recensioni/film/{filmId}")
	public String salva(@PathVariable("filmId") Long filmId, @Valid @ModelAttribute("recensione") Recensione recensione,
			BindingResult errori, Authentication authentication, Model model, RedirectAttributes redirectAttributes) {
		if (errori.hasErrors()) {
			model.addAttribute("film", this.filmService.findById(filmId));
			return "recensioni/recensione-form";
		}
		try {
			this.recensioneService.inserisci(filmId, authentication.getName(), recensione);
			redirectAttributes.addFlashAttribute("messaggio", "Recensione inserita");
		} catch (OperazioneNonConsentitaException e) {
			redirectAttributes.addFlashAttribute("messaggio", e.getMessage());
		} catch (DataIntegrityViolationException e) {
			// due richieste simultanee: ha vinto l'altra, il vincolo unique ha bloccato questa
			redirectAttributes.addFlashAttribute("messaggio", "Hai già scritto una recensione per questo film");
		}
		return "redirect:/films/" + filmId;
	}

	// ---------- MODIFICA (solo l'autore) ----------
	@GetMapping("/recensioni/{id}/edit")
	public String modifica(@PathVariable("id") Long id, Authentication authentication, Model model,
			RedirectAttributes redirectAttributes) {
		Recensione recensione = this.recensioneService.findById(id);
		Long filmId = recensione.getFilm().getId();
		if (!this.recensioneService.isAutore(recensione, authentication.getName())) {
			redirectAttributes.addFlashAttribute("messaggio", "Puoi modificare solo le tue recensioni");
			return "redirect:/films/" + filmId;
		}
		model.addAttribute("film", recensione.getFilm());
		model.addAttribute("recensione", recensione);
		return "recensioni/recensione-form";
	}

	@PostMapping("/recensioni/{id}")
	public String aggiorna(@PathVariable("id") Long id, @Valid @ModelAttribute("recensione") Recensione recensione,
			BindingResult errori, Authentication authentication, Model model, RedirectAttributes redirectAttributes) {
		Long filmId = this.recensioneService.findById(id).getFilm().getId();
		recensione.setId(id); // serve al modulo per capire che e' una modifica se si torna indietro con errori
		if (errori.hasErrors()) {
			model.addAttribute("film", this.filmService.findById(filmId));
			return "recensioni/recensione-form";
		}
		try {
			this.recensioneService.modifica(id, authentication.getName(), recensione);
			redirectAttributes.addFlashAttribute("messaggio", "Modifica effettuata");
		} catch (OperazioneNonConsentitaException e) {
			redirectAttributes.addFlashAttribute("messaggio", e.getMessage());
		}
		return "redirect:/films/" + filmId;
	}

	// ---------- ELIMINAZIONE (solo l'autore) ----------
	@PostMapping("/recensioni/{id}/elimina")
	public String elimina(@PathVariable("id") Long id, Authentication authentication,
			RedirectAttributes redirectAttributes) {
		Long filmId = this.recensioneService.findById(id).getFilm().getId();
		try {
			this.recensioneService.elimina(id, authentication.getName());
			redirectAttributes.addFlashAttribute("messaggio", "Recensione eliminata");
		} catch (OperazioneNonConsentitaException e) {
			redirectAttributes.addFlashAttribute("messaggio", e.getMessage());
		}
		return "redirect:/films/" + filmId;
	}
}
