package it.uniroma3.siw.exception;

// Lanciata dal service quando la programmazione di una proiezione non e' consentita
// (film non nel festival, data fuori dal festival, sala occupata). Essendo una RuntimeException
// fa fare il rollback della transazione.
public class ProgrammazioneNonValidaException extends RuntimeException {
	private static final long serialVersionUID = 1L;

	public ProgrammazioneNonValidaException(String messaggio) {
		super(messaggio);
	}
}
