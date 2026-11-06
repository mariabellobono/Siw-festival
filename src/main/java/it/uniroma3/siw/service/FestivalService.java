package it.uniroma3.siw.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import it.uniroma3.siw.exception.FestivalNotFoundException;
import it.uniroma3.siw.model.Festival;
import it.uniroma3.siw.repository.FestivalRepository;

@Service
public class FestivalService {
	private final FestivalRepository festivalRepository;

    public FestivalService(FestivalRepository festivalRepository) {
        this.festivalRepository = festivalRepository;
    }

    @Transactional(readOnly = true)
    public Iterable<Festival> findAll() {
        return this.festivalRepository.findAll();
    }

    @Transactional(readOnly = true)
    public Festival findById(Long id) {
        return this.festivalRepository.findById(id)
                .orElseThrow(() -> new FestivalNotFoundException(id));
    }

    @Transactional
    public Festival save(Festival festival) {
        return this.festivalRepository.save(festival);
    }

}
