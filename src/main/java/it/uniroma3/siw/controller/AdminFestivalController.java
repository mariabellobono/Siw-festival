package it.uniroma3.siw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
}
