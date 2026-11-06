package it.uniroma3.siw.repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.repository.CrudRepository;

import it.uniroma3.siw.model.Proiezione;

public interface ProiezioneRepository extends CrudRepository<Proiezione, Long> {

	// Proiezioni di una sala in un intervallo di giorni (estremi inclusi).
	// Serve per il controllo di sovrapposizione: si cerca dal giorno prima al giorno dopo
	// per coprire anche le proiezioni che attraversano la mezzanotte.
	List<Proiezione> findBySalaIdAndDataBetween(Long salaId, LocalDate da, LocalDate a);
}
