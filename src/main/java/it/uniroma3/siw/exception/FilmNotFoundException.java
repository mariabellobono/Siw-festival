package it.uniroma3.siw.exception;

public class FilmNotFoundException extends RuntimeException {
	private static final long serialVersionUID = 1L;
	
	public FilmNotFoundException(Long id) {
		super("Il film con ID " + id + " non esiste."); 
	}

}
