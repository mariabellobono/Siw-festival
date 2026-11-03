package it.uniroma3.siw.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.OneToMany;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

// ANAGRAFICA: chi e' la persona. Le credenziali di accesso (username, password, ruolo)
// stanno nella classe Credenziali (slide 10: User + Credentials).
// Perche' separate: l'anagrafica serve alle pagine (es. "recensione di Maria Rossi"),
// le credenziali servono solo al login. Alternativa: tutto in una classe sola (piu' semplice,
// ma la password viaggerebbe insieme ai dati della persona).
@Entity
public class Utente extends EntitaBase {

	@NotBlank
	private String nome;

	@NotBlank
	private String cognome;

	@Column(unique = true, nullable = false)
	@NotBlank
	@Email
	private String email;

	// LISTE INIZIALIZZATE (vale per tutte le liste di questa classe).
	// Perche': un oggetto creato con "new" (es. dalla form) avrebbe la lista null e
	// getX().add(...) lancerebbe NullPointerException. Cosi' la lista e' sempre pronta.
	// Quando Hibernate carica dal DB sostituisce comunque la lista con la sua.
	// Alternativa: lasciarla null e controllare "if (lista == null)" nel service prima
	// di ogni add: funziona, ma va ripetuto in ogni metodo ed e' facile dimenticarlo.
	@OneToMany(mappedBy = "utente")
	private List<Recensione> recensioni = new ArrayList<>();

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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public List<Recensione> getRecensioni() {
		return recensioni;
	}

	public void setRecensioni(List<Recensione> recensioni) {
		this.recensioni = recensioni;
	}

	// L'email identifica la persona (e' unica): e' il campo naturale per equals/hashCode.
	@Override
	public int hashCode() {
		return Objects.hash(email);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null || getClass() != obj.getClass())
			return false;
		Utente other = (Utente) obj;
		return Objects.equals(email, other.email);
	}
}
