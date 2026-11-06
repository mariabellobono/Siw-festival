package it.uniroma3.siw.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import it.uniroma3.siw.model.Film;

public interface FilmRepository extends CrudRepository<Film, Long> {
	boolean existsByTitoloAndAnno(String titolo, Integer anno);

	// Per la modifica: esiste un ALTRO film (id diverso) con lo stesso titolo e anno?
	boolean existsByTitoloAndAnnoAndIdNot(String titolo, Integer anno, Long id);

	// Film di un regista, dal piu' vecchio al piu' recente (OrderByAnno = ORDER BY anno)
	List<Film> findByRegistaOrderByAnno(String regista);

}
