package it.uniroma3.siw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import it.uniroma3.siw.model.Sala;
import it.uniroma3.siw.service.SalaService;
import jakarta.validation.Valid;

@Controller
public class AdminSalaController {
	private final SalaService salaService;

	public AdminSalaController(SalaService salaService) {
		this.salaService = salaService;
	}

	@GetMapping("/admin/sale/new")
	public String inserisciSala(Model model) {
		model.addAttribute("sala", new Sala());
		return "admin/sala-form";
	}

	@PostMapping("/admin/sale")
	public String salvaSala(@Valid @ModelAttribute("sala") Sala sala, BindingResult errori, RedirectAttributes redirectAttributes) {
		if(errori.hasErrors()) {
			return "admin/sala-form";
		}
		sala.setId(null);
		salaService.save(sala);

		redirectAttributes.addFlashAttribute("messaggio", "Inserimento effettuato");
		return "redirect:/sale/" + sala.getId();
	}

	@GetMapping("/admin/sale/{id}/edit")
	public String modificaSala(@PathVariable("id") Long id, Model model) {
		model.addAttribute("sala", salaService.findById(id));
		return "admin/sala-form";
	}

	@PostMapping("/admin/sale/{id}")
	public String aggiornaSala(@PathVariable("id") Long id, @Valid @ModelAttribute("sala") Sala sala,
			BindingResult errori, RedirectAttributes redirectAttributes) {
		sala.setId(id);
		if(errori.hasErrors()) {
			return "admin/sala-form";
		}
		salaService.aggiorna(id, sala);

		redirectAttributes.addFlashAttribute("messaggio", "Modifica effettuata");
		return "redirect:/sale/" + id;
	}
}
