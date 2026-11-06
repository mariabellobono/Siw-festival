package it.uniroma3.siw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
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
}
