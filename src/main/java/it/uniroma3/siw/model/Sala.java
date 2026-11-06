package it.uniroma3.siw.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import jakarta.persistence.*;
import jakarta.persistence.OneToMany;
import jakarta.validation.constraints.*;


@Entity
public class Sala extends EntitaBase {

	@NotBlank(message = "Compila il campo vuoto")
	private String nome;
	
	@NotBlank(message = "Compila il campo vuoto")
	private String indirizzo;
	
	@NotNull(message = "Compila il campo vuoto") @Positive(message = "La capienza deve essere maggiore di 0")
	private Integer capienza;
	
	// LISTE INIZIALIZZATE (vale per tutte le liste di questa classe).
	// Perche': un oggetto creato con "new" (es. dalla form) avrebbe la lista null e
	// getX().add(...) lancerebbe NullPointerException. Cosi' la lista e' sempre pronta.
	// Quando Hibernate carica dal DB sostituisce comunque la lista con la sua.
	// Alternativa: lasciarla null e controllare "if (lista == null)" nel service prima
	// di ogni add: funziona, ma va ripetuto in ogni metodo ed e' facile dimenticarlo.
	@OneToMany(mappedBy = "sala")
	private List<Proiezione> proiezioni = new ArrayList<>();

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getIndirizzo() {
		return indirizzo;
	}

	public void setIndirizzo(String indirizzo) {
		this.indirizzo = indirizzo;
	}

	public Integer getCapienza() {
		return capienza;
	}

	public void setCapienza(Integer capienza) {
		this.capienza = capienza;
	}

	public List<Proiezione> getProiezioni() {
		return proiezioni;
	}

	public void setProiezioni(List<Proiezione> proiezioni) {
		this.proiezioni = proiezioni;
	}

	@Override
	public int hashCode() {
		return Objects.hash(nome, indirizzo);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null || getClass() != obj.getClass())
			return false;
		Sala other = (Sala) obj;
		return Objects.equals(nome, other.nome) && Objects.equals(indirizzo, other.indirizzo);
	}

}
