package it.uniroma3.siw.repository;

import org.springframework.data.repository.CrudRepository;

import it.uniroma3.siw.model.Sala;

public interface SalaRepository extends CrudRepository<Sala, Long> {

	// ORDINAMENTI (count() c'e' gia' in CrudRepository)
	java.util.List<Sala> findAllByOrderByNomeAsc();
	java.util.List<Sala> findAllByOrderByCapienzaDesc();

	
}
