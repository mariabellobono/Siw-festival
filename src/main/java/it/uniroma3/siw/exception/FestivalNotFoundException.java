package it.uniroma3.siw.exception;

public class FestivalNotFoundException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public FestivalNotFoundException(Long id) {
        super("Il festival con ID " + id + " non esiste.");
    }
}
