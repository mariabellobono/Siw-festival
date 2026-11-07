package it.uniroma3.siw.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import it.uniroma3.siw.validation.NotFutureYear;
import jakarta.persistence.*;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(uniqueConstraints = @UniqueConstraint(columnNames = {"titolo", "anno"}))
public class Film extends EntitaBase{
	@Column(nullable = false)
	@NotBlank(message = "Compila il campo vuoto")
	private String titolo;

	@NotNull(message = "Compila il campo vuoto") @Min(value = 1895, message = "Anno non valido") @NotFutureYear
	private Integer anno;

	@NotNull(message = "Compila il campo vuoto") @Min(value = 1, message = "La durata deve essere di almeno 1 minuto")
	private Integer durata;

	@NotBlank(message = "Compila il campo vuoto")
	private String genere;

	@NotBlank(message = "Compila il campo vuoto")
	private String paeseProduzione;

	// INTEGRAZIONE: il testo del progetto cita il regista (dettaglio film e ricerca bonus)
	// ma non lo elenca tra gli attributi. Scelto un semplice campo testo; alternativa:
	// @ManyToOne verso Attore (piu' complessa, e un regista non e' per forza un attore).
	@NotBlank(message = "Compila il campo vuoto")
	private String regista;

	// LISTE INIZIALIZZATE (vale per tutte le liste di questa classe).
	// Perche': un oggetto creato con "new" (es. dalla form) avrebbe la lista null e
	// getX().add(...) lancerebbe NullPointerException. Cosi' la lista e' sempre pronta.
	// Quando Hibernate carica dal DB sostituisce comunque la lista con la sua.
	// Alternativa: lasciarla null e controllare "if (lista == null)" nel service prima
	// di ogni add: funziona, ma va ripetuto in ogni metodo ed e' facile dimenticarlo.
	@ManyToMany
	private List<Festival> festival = new ArrayList<>();

	@OneToMany(mappedBy = "film",cascade = CascadeType.REMOVE)
	private List<Proiezione> proiezioni = new ArrayList<>();

	@OneToMany(mappedBy = "film",cascade = CascadeType.REMOVE)
	private List<Recensione> recensioni = new ArrayList<>();

	@OneToMany(mappedBy = "film",cascade = CascadeType.REMOVE)
	private List<Interpretazione> interpretazioni = new ArrayList<>();

	public String getTitolo() {
		return titolo;
	}

	public void setTitolo(String titolo) {
		this.titolo = titolo;
	}

	public Integer getAnno() {
		return anno;
	}

	public void setAnno(Integer anno) {
		this.anno = anno;
	}

	public Integer getDurata() {
		return durata;
	}

	public void setDurata(Integer durata) {
		this.durata = durata;
	}

	public String getGenere() {
		return genere;
	}

	public void setGenere(String genere) {
		this.genere = genere;
	}

	public String getPaeseProduzione() {
		return paeseProduzione;
	}

	public void setPaeseProduzione(String paeseProduzione) {
		this.paeseProduzione = paeseProduzione;
	}


	public List<Festival> getFestival() {
		return festival;
	}

	public void setFestival(List<Festival> festival) {
		this.festival = festival;
	}


	public List<Proiezione> getProiezioni() {
		return proiezioni;
	}

	public void setProiezioni(List<Proiezione> proiezioni) {
		this.proiezioni = proiezioni;
	}

	public List<Recensione> getRecensioni() {
		return recensioni;
	}

	public void setRecensioni(List<Recensione> recensioni) {
		this.recensioni = recensioni;
	}
	public String getRegista() {
		return regista;
	}

	public void setRegista(String regista) {
		this.regista = regista;
	}




public List<Interpretazione> getInterpretazioni() {
	return interpretazioni;
}

public void setInterpretazioni(List<Interpretazione> interpretazioni) {
	this.interpretazioni = interpretazioni;
}

@Override
public int hashCode() {
	return Objects.hash(titolo, anno);
}

@Override
public boolean equals(Object obj) {
	if (this == obj)
		return true;
	if (obj == null || getClass() != obj.getClass())
		return false;
	Film other = (Film) obj;
	return Objects.equals(titolo, other.titolo) && Objects.equals(anno, other.anno);
}
}


