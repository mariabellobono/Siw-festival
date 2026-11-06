package it.uniroma3.siw.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import it.uniroma3.siw.exception.AttoreNotFoundException;
import it.uniroma3.siw.model.Attore;
import it.uniroma3.siw.repository.AttoreRepository;

@Service
public class AttoreService {
	private final AttoreRepository attoreRepository;

	public AttoreService(AttoreRepository attoreRepository) {
		this.attoreRepository = attoreRepository;
	}

	@Transactional(readOnly = true)
	public Attore findById(Long id) {
		return this.attoreRepository.findById(id)
				.orElseThrow(() -> new AttoreNotFoundException(id));
	}
}
