package it.uniroma3.siw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import it.uniroma3.siw.model.Stato;
import it.uniroma3.siw.service.AttoreService;
import it.uniroma3.siw.service.FestivalService;
import it.uniroma3.siw.service.FilmService;
import it.uniroma3.siw.service.ProiezioneService;
import it.uniroma3.siw.service.SalaService;

@Controller
public class HomeController {

	private final FilmService filmService;
	private final FestivalService festivalService;
	private final SalaService salaService;
	private final AttoreService attoreService;
	private final ProiezioneService proiezioneService;

	public HomeController(FilmService filmService, FestivalService festivalService, SalaService salaService,
			AttoreService attoreService, ProiezioneService proiezioneService) {
		this.filmService = filmService;
		this.festivalService = festivalService;
		this.salaService = salaService;
		this.attoreService = attoreService;
		this.proiezioneService = proiezioneService;
	}

	@GetMapping("/")
	public String home(Model model) {
		// I totali della fascia in home: ogni numero e' un count(*) fatto dal database
		model.addAttribute("numeroFilm", filmService.numero());
		model.addAttribute("numeroFestival", festivalService.numero());
		model.addAttribute("numeroSale", salaService.numero());
		model.addAttribute("numeroAttori", attoreService.numero());
		model.addAttribute("numeroProgrammate", proiezioneService.numeroPerStato(Stato.SCHEDULED));
		return "index";
	}
}
