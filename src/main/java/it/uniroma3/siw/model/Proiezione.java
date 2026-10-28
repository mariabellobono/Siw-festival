package it.uniroma3.siw.model;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Objects;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;


@Entity
public class Proiezione extends EntitaBase{
	@Column(nullable = false)
	@NotNull
	private LocalDate data;
	@Column(nullable = false)
	@NotNull
	private LocalTime ora;
	
	@Enumerated(EnumType.STRING)
	private Stato stato;
	

	@ManyToOne
	private Festival festival;
	
	@ManyToOne
	private Film film;
	
	@ManyToOne
	private Sala sala;

	public LocalDate getData() {
		return data;
	}

	public void setData(LocalDate data) {
		this.data = data;
	}

	public LocalTime getOra() {
		return ora;
	}

	public void setOra(LocalTime ora) {
		this.ora = ora;
	}

	public Stato getStato() {
		return stato;
	}

	public void setStato(Stato stato) {
		this.stato = stato;
	}

	public Festival getFestival() {
		return festival;
	}

	public void setFestival(Festival festival) {
		this.festival = festival;
	}

	public Film getFilm() {
		return film;
	}

	public void setFilm(Film film) {
		this.film = film;
	}

	public Sala getSala() {
		return sala;
	}

	public void setSala(Sala sala) {
		this.sala = sala;
	}

	@Override
	public int hashCode() {
		return Objects.hash(sala, data, ora);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null || getClass() != obj.getClass())
			return false;
		Proiezione other = (Proiezione) obj;
		return Objects.equals(sala, other.sala) && Objects.equals(data, other.data) && Objects.equals(ora, other.ora);
	}

}
