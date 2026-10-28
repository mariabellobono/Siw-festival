package it.uniroma3.siw.model;

import java.time.LocalDate;
import java.util.Objects;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;

@Entity
@Table(uniqueConstraints = @UniqueConstraint(columnNames = {"film_id", "utente_id"}))
public class Recensione extends EntitaBase{
	
	@NotBlank
	private String testo;
	
	@Column(nullable = false)
	@NotNull @Min(1) @Max(5)
	private Integer voto;
	
	private LocalDate data;
	
	@ManyToOne
	private Film film;
	
	
	@ManyToOne
	private Utente utente;

	public String getTesto() {
		return testo;
	}

	public void setTesto(String testo) {
		this.testo = testo;
	}

	public Integer getVoto() {
		return voto;
	}

	public void setVoto(Integer voto) {
		this.voto = voto;
	}

	public LocalDate getData() {
		return data;
	}

	public void setData(LocalDate data) {
		this.data = data;
	}

	public Film getFilm() {
		return film;
	}

	public void setFilm(Film film) {
		this.film = film;
	}

	public Utente getUtente() {
		return utente;
	}

	public void setUtente(Utente utente) {
		this.utente = utente;
	}

	@Override
	public int hashCode() {
		return Objects.hash(film, utente);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null || getClass() != obj.getClass())
			return false;
		Recensione other = (Recensione) obj;
		return Objects.equals(film, other.film) && Objects.equals(utente, other.utente);
	}

}
