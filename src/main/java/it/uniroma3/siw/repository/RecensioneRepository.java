package it.uniroma3.siw.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import it.uniroma3.siw.model.Recensione;

public interface RecensioneRepository extends CrudRepository<Recensione, Long> {

	// La recensione scritta da un utente per un film (al massimo una: vincolo unique sul database)
	Optional<Recensione> findByFilmIdAndUtenteId(Long filmId, Long utenteId);

	boolean existsByFilmIdAndUtenteId(Long filmId, Long utenteId);

	// Recensioni di un film, dalla piu' recente; l'autore (utente) arriva nella stessa query (EntityGraph)
	@EntityGraph(attributePaths = "utente")
	List<Recensione> findByFilmIdOrderByDataDescIdDesc(Long filmId);

	long countByFilmId(Long filmId);

	// Media dei voti calcolata dal database (null se il film non ha recensioni)
	@Query("select avg(r.voto) from Recensione r where r.film.id = :filmId")
	Double mediaVoti(@Param("filmId") Long filmId);
}
