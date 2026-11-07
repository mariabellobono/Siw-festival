package it.uniroma3.siw.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import it.uniroma3.siw.exception.OperazioneNonConsentitaException;
import it.uniroma3.siw.exception.SalaNotFoundException;
import it.uniroma3.siw.model.Sala;
import it.uniroma3.siw.repository.SalaRepository;


@Service
public class SalaService {

	private final SalaRepository salaRepository;
	
	public SalaService(SalaRepository salaRepository) {
		this.salaRepository = salaRepository;
		
	}
	@Transactional(readOnly = true)
	public Iterable<Sala> findAll(){
		return this.salaRepository.findAll();
	}
	
	@Transactional(readOnly = true)
	public Sala findById(Long id) {
		return this.salaRepository.findById(id)
				.orElseThrow( () -> new SalaNotFoundException(id) );
				
		
	}

	@Transactional
	public Sala save(Sala sala) {
		return this.salaRepository.save(sala);
	}

	// ELIMINAZIONE: una sala con proiezioni (anche annullate: restano nello storico) non si cancella
	@Transactional
	public void elimina(Long id) {
		Sala sala = findById(id);
		if (!sala.getProiezioni().isEmpty()) {
			throw new OperazioneNonConsentitaException("La sala ha delle proiezioni e non puo essere eliminata");
		}
		this.salaRepository.delete(sala);
	}

	// MODIFICA: si carica la sala dal database e si copiano solo i campi del modulo
	// (cosi' la lista delle proiezioni della sala non viene toccata)
	@Transactional
	public Sala aggiorna(Long id, Sala dati) {
		Sala sala = this.salaRepository.findById(id)
				.orElseThrow(() -> new SalaNotFoundException(id));
		sala.setNome(dati.getNome());
		sala.setIndirizzo(dati.getIndirizzo());
		sala.setCapienza(dati.getCapienza());
		return this.salaRepository.save(sala);
	}
}
