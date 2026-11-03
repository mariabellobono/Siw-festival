package it.uniroma3.siw.service;

import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import it.uniroma3.siw.model.Credenziali;
import it.uniroma3.siw.repository.CredenzialiRepository;

@Service
public class CredenzialiService {

	private final CredenzialiRepository credenzialiRepository;

	public CredenzialiService(CredenzialiRepository credenzialiRepository) {
		this.credenzialiRepository = credenzialiRepository;
	}

	@Transactional(readOnly = true)
	public Optional<Credenziali> findByUsername(String username) {
		return this.credenzialiRepository.findByUsername(username);
	}

	@Transactional(readOnly = true)
	public boolean existsByUsername(String username) {
		return this.credenzialiRepository.existsByUsername(username);
	}

	// La cifratura della password (BCrypt) viene aggiunta nel blocco 2, con Spring Security.
	@Transactional
	public Credenziali save(Credenziali credenziali) {
		return this.credenzialiRepository.save(credenziali);
	}

}
