package it.uniroma3.siw.repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import it.uniroma3.siw.model.Proiezione;

public interface ProiezioneRepository extends CrudRepository<Proiezione, Long> {

	// Proiezioni di una sala in un intervallo di giorni (estremi inclusi).
	// Serve per il controllo di sovrapposizione: si cerca dal giorno prima al giorno dopo
	// per coprire anche le proiezioni che attraversano la mezzanotte.
	List<Proiezione> findBySalaIdAndDataBetween(Long salaId, LocalDate da, LocalDate a);

	// Tutte le proiezioni CON film, sala e festival in UNA SOLA query (EntityGraph = "carica anche questi").
	// Senza il grafo, ogni proiezione causerebbe query in piu' per il suo film, la sua sala e il suo festival (N+1).
	@EntityGraph(attributePaths = { "film", "sala", "festival" })
	@Query("select p from Proiezione p order by p.data, p.ora")
	List<Proiezione> findAllConDettagli();

	// Proiezioni di un giorno (filtro per data dell'API), con film, sala e festival gia' caricati
	@EntityGraph(attributePaths = { "film", "sala", "festival" })
	List<Proiezione> findByDataOrderByOra(LocalDate data);

	// Programma di un festival, in ordine cronologico
	@EntityGraph(attributePaths = { "film", "sala", "festival" })
	List<Proiezione> findByFestivalIdOrderByDataAscOraAsc(Long festivalId);
}
