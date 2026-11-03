package it.uniroma3.siw.exception;

public class SalaNotFoundException extends RuntimeException{
	private static final long serialVersionUID = 1L;
	
	public SalaNotFoundException(Long id){
		super("la sala con ID " + id + " non esiste.");
		
		
	}

}
