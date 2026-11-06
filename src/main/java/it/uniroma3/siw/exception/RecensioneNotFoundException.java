package it.uniroma3.siw.exception;

public class RecensioneNotFoundException extends RuntimeException {
	private static final long serialVersionUID = 1L;

	public RecensioneNotFoundException(Long id) {
		super("la recensione con ID " + id + " non esiste.");
	}
}
