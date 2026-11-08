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

	// CONTEGGIO nel database
	@Transactional(readOnly = true)
	public long numero() {
		return this.attoreRepository.count();
	}

	@Transactional(readOnly = true)
	public Attore findById(Long id) {
		return this.attoreRepository.findById(id)
				.orElseThrow(() -> new AttoreNotFoundException(id));
	}

	// MODIFICA: si carica l'attore dal database e si copiano solo i campi del modulo
	// (cosi' la lista delle interpretazioni non viene toccata)
	@Transactional
	public Attore aggiorna(Long id, Attore dati) {
		Attore attore = findById(id);
		attore.setNome(dati.getNome());
		attore.setCognome(dati.getCognome());
		attore.setDataNascita(dati.getDataNascita());
		attore.setNazionalita(dati.getNazionalita());
		return this.attoreRepository.save(attore);
	}
}
