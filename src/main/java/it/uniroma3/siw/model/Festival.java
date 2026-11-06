package it.uniroma3.siw.model;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.OneToMany;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

@Entity
public class Festival extends EntitaBase{

	@Column(nullable = false)
	@NotBlank(message = "Compila il campo vuoto")
	private String nome;

	@NotNull(message = "Compila il campo vuoto") @Min(value = 1900, message = "Anno non valido") @Max(value = 2100, message = "Anno non valido")
	private Integer anno;
	
	@Column(nullable = false)
	@NotBlank(message = "Compila il campo vuoto")
	private String citta;
	
	@NotNull(message = "Compila il campo vuoto")
	private LocalDate dataInizio;
	
	@NotNull(message = "Compila il campo vuoto")
	private LocalDate dataFine;
	
	private String descrizione;

	// LISTE INIZIALIZZATE (vale per tutte le liste di questa classe).
	// Perche': un oggetto creato con "new" (es. dalla form) avrebbe la lista null e
	// getX().add(...) lancerebbe NullPointerException. Cosi' la lista e' sempre pronta.
	// Quando Hibernate carica dal DB sostituisce comunque la lista con la sua.
	// Alternativa: lasciarla null e controllare "if (lista == null)" nel service prima
	// di ogni add: funziona, ma va ripetuto in ogni metodo ed e' facile dimenticarlo.
	@ManyToMany(mappedBy = "festival")
	private List<Film> films = new ArrayList<>();
	
	@OneToMany(mappedBy = "festival")
	private List<Proiezione> proiezioni = new ArrayList<>();

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public Integer getAnno() {
		return anno;
	}

	public void setAnno(Integer anno) {
		this.anno = anno;
	}

	public String getCitta() {
		return citta;
	}

	public void setCitta(String citta) {
		this.citta = citta;
	}

	public LocalDate getDataInizio() {
		return dataInizio;
	}

	public void setDataInizio(LocalDate dataInizio) {
		this.dataInizio = dataInizio;
	}

	public LocalDate getDataFine() {
		return dataFine;
	}

	public void setDataFine(LocalDate dataFine) {
		this.dataFine = dataFine;
	}

	public String getDescrizione() {
		return descrizione;
	}

	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}

	public List<Film> getFilms() {
		return films;
	}

	public void setFilms(List<Film> films) {
		this.films = films;
	}

	public List<Proiezione> getProiezioni() {
		return proiezioni;
	}

	public void setProiezioni(List<Proiezione> proiezioni) {
		this.proiezioni = proiezioni;
	}

	@Override
	public int hashCode() {
		return Objects.hash(nome,anno);
		
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null || getClass() != obj.getClass())
			return false;
		Festival other = (Festival) obj;
		return Objects.equals(anno, other.anno) && Objects.equals(nome, other.nome);
		
	}

}