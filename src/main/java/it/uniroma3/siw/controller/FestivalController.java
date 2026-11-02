package it.uniroma3.siw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import it.uniroma3.siw.service.FestivalService;

@Controller
public class FestivalController {
	
	private final FestivalService festivalService;
	
	 public FestivalController (FestivalService festivalService) {
			this.festivalService = festivalService;
			
	
		
	}
	 @GetMapping("/festivals")
	 public String tuttifestival(Model model) {
		 model.addAttribute("festivals",this.festivalService.findAll());
		 return "festivals/tuttifestival";
	 }
	 
	 @GetMapping("/festivals/{id}")
	 public String singoloFestival(@PathVariable("id")Long id,Model model) {
		 model.addAttribute("festival", this.festivalService.findById(id));
		 return "festivals/festival";
	 }
	

}
