package it.uniroma3.siw.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.resource.NoResourceFoundException;

import it.uniroma3.siw.exception.FestivalNotFoundException;
import it.uniroma3.siw.exception.FilmNotFoundException;
import it.uniroma3.siw.exception.ProiezioneNotFoundException;
import it.uniroma3.siw.exception.SalaNotFoundException;

// Una sola classe che intercetta le eccezioni di TUTTI i controller.
// Alternativa: un try/catch in ogni metodo del controller, ma si ripeterebbe ovunque.
@ControllerAdvice
public class AllExceptionHandler {

	private static final Logger log = LoggerFactory.getLogger(AllExceptionHandler.class);

	// Quando una di queste eccezioni esce da un controller, parte questo metodo.
	@ExceptionHandler({ FestivalNotFoundException.class, FilmNotFoundException.class,SalaNotFoundException.class, ProiezioneNotFoundException.class })
	@ResponseStatus(HttpStatus.NOT_FOUND) // la risposta HTTP deve essere 404, non 200
	public String risorsaNonTrovata(RuntimeException ex, Model model) {
		model.addAttribute("messaggio", ex.getMessage());
		return "error/404";
	}

	// Indirizzo inesistente (es. /pippo): Spring lancia questa eccezione.
	@ExceptionHandler(NoResourceFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String paginaNonTrovata(Model model) {
		model.addAttribute("messaggio", "La pagina richiesta non esiste.");
		return "error/404";
	}

	// Qualsiasi altro errore imprevisto uscito da un controller o da un service (bug, DB non raggiungibile...).
	// All'utente mostriamo una pagina generica (niente dettagli tecnici); il dettaglio va nel log.
	// Spring sceglie sempre il metodo piu' specifico: i 404 qui sopra non finiscono in questo.
	@ExceptionHandler(Exception.class)
	@ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
	public String erroreInterno(Exception ex) {
		log.error("Errore imprevisto", ex);
		return "error/500";
	}
}