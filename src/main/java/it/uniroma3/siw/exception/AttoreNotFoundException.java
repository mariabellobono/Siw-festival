package it.uniroma3.siw.exception;

public class AttoreNotFoundException extends RuntimeException {
	private static final long serialVersionUID = 1L;

	public AttoreNotFoundException(Long id) {
		super("l'attore con ID " + id + " non esiste.");
	}
}
