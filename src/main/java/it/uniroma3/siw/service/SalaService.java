package it.uniroma3.siw.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	
	
	
	
	
}
