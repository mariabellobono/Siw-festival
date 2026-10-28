package it.uniroma3.siw.model;

import java.util.Objects;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;

@Entity 
public class Interpretazione extends EntitaBase {

	@NotBlank
	private String personaggio;

	@ManyToOne
	private Film film;

	@ManyToOne
	private Attore attore;

	public String getPersonaggio() {
		return personaggio;
	}

	public void setPersonaggio(String personaggio) {
		this.personaggio = personaggio;
	}

	
	public Film getFilm() {
		return film;
	}

	public void setFilm(Film film) {
		this.film = film;
	}

	public Attore getAttore() {
		return attore;
	}

	public void setAttore(Attore attore) {
		this.attore = attore;
	}

	@Override
	public int hashCode() {
		return Objects.hash(film, attore, personaggio);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null || getClass() != obj.getClass())
			return false;
		Interpretazione other = (Interpretazione) obj;
		return Objects.equals(film, other.film) && Objects.equals(attore, other.attore) && Objects.equals(personaggio, other.personaggio);
	}

}
