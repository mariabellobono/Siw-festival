package it.uniroma3.siw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import it.uniroma3.siw.service.ProiezioneService;

@Controller
public class ProiezioneController {

	private final ProiezioneService proiezioneService;

	public ProiezioneController(ProiezioneService proiezioneService) {
		this.proiezioneService = proiezioneService;
	}

	@GetMapping("/proiezioni")
	public String tutteProiezioni(@RequestParam(name = "ordina", required = false) String ordina, Model model) {
		model.addAttribute("proiezioni", proiezioneService.elenco(ordina));
		model.addAttribute("totaleProiezioni", proiezioneService.numero());
		return "proiezioni/tutteproiezioni";
	}

	@GetMapping("/proiezioni/{id}")
	public String singolaProiezione(@PathVariable("id") Long id, Model model) {
		model.addAttribute("proiezione", proiezioneService.findById(id));
		return "proiezioni/proiezione";
	}

}
