package it.uniroma3.siw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import it.uniroma3.siw.service.SalaService;

@Controller
public class SalaController {

	private final SalaService salaService;
	
	public SalaController(SalaService salaService) {
		this.salaService = salaService;
		
	}
	@GetMapping("/sale")
	public String tutteSale(@RequestParam(name = "ordina", required = false) String ordina, Model model) {
		model.addAttribute("sale", salaService.elenco(ordina));
		model.addAttribute("totaleSale", salaService.numero());
		return "sale/tuttesale";
		
	}
	@GetMapping("/sale/{id}")
	public String singolaSala(@PathVariable("id")Long id,Model model) {
		model.addAttribute("sala", salaService.findById(id));
		return "sale/sala";
		
		
	}
}
