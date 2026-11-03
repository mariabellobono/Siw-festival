package it.uniroma3.siw.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import it.uniroma3.siw.exception.ProiezioneNotFoundException;
import it.uniroma3.siw.model.Proiezione;
import it.uniroma3.siw.repository.ProiezioneRepository;

@Service
public class ProiezioneService {

	private final ProiezioneRepository proiezioneRepository;

	public ProiezioneService(ProiezioneRepository proiezioneRepository) {
		this.proiezioneRepository = proiezioneRepository;
	}

	@Transactional(readOnly = true)
	public Iterable<Proiezione> findAll() {
		return this.proiezioneRepository.findAll();
	}

	@Transactional(readOnly = true)
	public Proiezione findById(Long id) {
		return this.proiezioneRepository.findById(id)
				.orElseThrow(() -> new ProiezioneNotFoundException(id));
	}

}
