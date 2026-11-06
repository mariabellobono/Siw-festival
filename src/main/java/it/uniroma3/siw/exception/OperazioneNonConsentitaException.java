package it.uniroma3.siw.exception;

// Lanciata dai service quando un'operazione viola una regola di consistenza (es. film gia' nel festival,
// film con proiezioni programmate che non si puo' togliere dal festival). E' una RuntimeException:
// se lanciata dentro un metodo @Transactional provoca il rollback.
public class OperazioneNonConsentitaException extends RuntimeException {
	private static final long serialVersionUID = 1L;

	public OperazioneNonConsentitaException(String messaggio) {
		super(messaggio);
	}
}
