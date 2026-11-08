package it.uniroma3.siw.repository;

import org.springframework.data.repository.CrudRepository;

import it.uniroma3.siw.model.Festival;

public interface FestivalRepository extends CrudRepository<Festival, Long> {

	// ORDINAMENTI (count() c'e' gia' in CrudRepository)
	java.util.List<Festival> findAllByOrderByNomeAsc();
	java.util.List<Festival> findAllByOrderByAnnoDesc();
	java.util.List<Festival> findAllByOrderByCittaAsc();

	
}
