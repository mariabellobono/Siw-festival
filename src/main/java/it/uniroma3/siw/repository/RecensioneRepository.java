package it.uniroma3.siw.repository;

import java.util.Optional;

import org.springframework.data.repository.CrudRepository;

import it.uniroma3.siw.model.Recensione;

public interface RecensioneRepository extends CrudRepository<Recensione, Long> {

	// La recensione scritta da un utente per un film (al massimo una: vincolo unique sul database)
	Optional<Recensione> findByFilmIdAndUtenteId(Long filmId, Long utenteId);

	boolean existsByFilmIdAndUtenteId(Long filmId, Long utenteId);
}
