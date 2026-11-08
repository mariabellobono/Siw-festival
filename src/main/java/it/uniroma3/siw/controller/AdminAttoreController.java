package it.uniroma3.siw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import it.uniroma3.siw.model.Attore;
import it.uniroma3.siw.service.AttoreService;
import jakarta.validation.Valid;

@Controller
public class AdminAttoreController {
	private final AttoreService attoreService;

	public AdminAttoreController(AttoreService attoreService) {
		this.attoreService = attoreService;
	}

	@GetMapping("/admin/attori/{id}/edit")
	public String modificaAttore(@PathVariable("id") Long id, Model model) {
		model.addAttribute("attore", attoreService.findById(id));
		return "admin/attore-form";
	}

	@PostMapping("/admin/attori/{id}")
	public String aggiornaAttore(@PathVariable("id") Long id, @Valid @ModelAttribute("attore") Attore attore,
			BindingResult errori, RedirectAttributes redirectAttributes) {
		attore.setId(id); // l'id arriva dall'indirizzo, serve anche al modulo se si torna indietro con errori
		if(errori.hasErrors()) {
			return "admin/attore-form";
		}
		attoreService.aggiorna(id, attore);

		redirectAttributes.addFlashAttribute("messaggio", "Modifica effettuata");
		return "redirect:/attori/" + id;
	}
}
