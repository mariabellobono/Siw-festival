package it.uniroma3.siw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import it.uniroma3.siw.service.AttoreService;

@Controller
public class AttoreController {
	private final AttoreService attoreService;

	public AttoreController(AttoreService attoreService) {
		this.attoreService = attoreService;
	}

	@GetMapping("/attori/{id}")
	public String singoloAttore(@PathVariable("id") Long id, Model model) {
		model.addAttribute("attore", attoreService.findById(id));
		return "attori/attore";
	}
}
