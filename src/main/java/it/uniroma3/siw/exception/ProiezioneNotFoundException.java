package it.uniroma3.siw.exception;

public class ProiezioneNotFoundException extends RuntimeException {
	private static final long serialVersionUID = 1L;

	public ProiezioneNotFoundException(Long id) {
		super("La proiezione con ID " + id + " non esiste.");
	}

}
