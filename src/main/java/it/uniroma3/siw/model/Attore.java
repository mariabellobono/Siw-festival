package it.uniroma3.siw.model;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.OneToMany;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

@Entity
public class Attore extends EntitaBase{
	@Column(nullable = false)
	@NotBlank
	private String nome;
	
	@Column(nullable = false)
	@NotBlank
	private String cognome;

	@NotNull
	private LocalDate dataNascita;

	@NotBlank
	private String nazionalita;

	
	
	// LISTE INIZIALIZZATE (vale per tutte le liste di questa classe).
	// Perche': un oggetto creato con "new" (es. dalla form) avrebbe la lista null e
	// getX().add(...) lancerebbe NullPointerException. Cosi' la lista e' sempre pronta.
	// Quando Hibernate carica dal DB sostituisce comunque la lista con la sua.
	// Alternativa: lasciarla null e controllare "if (lista == null)" nel service prima
	// di ogni add: funziona, ma va ripetuto in ogni metodo ed e' facile dimenticarlo.
	@OneToMany(mappedBy = "attore")
	private List<Interpretazione> interpretazioni = new ArrayList<>();

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getCognome() {
		return cognome;
	}

	public void setCognome(String cognome) {
		this.cognome = cognome;
	}

	public LocalDate getDataNascita() {
		return dataNascita;
	}

	public void setDataNascita(LocalDate dataNascita) {
		this.dataNascita = dataNascita;
	}

	public String getNazionalita() {
		return nazionalita;
	}

	public void setNazionalita(String nazionalita) {
		this.nazionalita = nazionalita;
	}

	public List<Interpretazione> getInterpretazioni() {
		return interpretazioni;
	}

	public void setInterpretazioni(List<Interpretazione> interpretazioni) {
		this.interpretazioni = interpretazioni;
	}

	@Override
	public int hashCode() {
		return Objects.hash(nome, cognome, dataNascita);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null || getClass() != obj.getClass())
			return false;
		Attore other = (Attore) obj;
		return Objects.equals(nome, other.nome) && Objects.equals(cognome, other.cognome) && Objects.equals(dataNascita, other.dataNascita);
	}

}
