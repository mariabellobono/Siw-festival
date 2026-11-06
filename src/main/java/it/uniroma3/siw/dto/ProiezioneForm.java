package it.uniroma3.siw.dto;

import java.time.LocalDate;
import java.time.LocalTime;

import jakarta.validation.constraints.NotNull;

// Oggetto del modulo "programma proiezione": contiene solo i valori inviati dal browser.
// Dalle tendine arrivano gli id (Long), non gli oggetti: sara' il service a caricare le entita'.
public class ProiezioneForm {

	@NotNull(message = "Compila il campo vuoto")
	private Long festivalId;

	@NotNull(message = "Compila il campo vuoto")
	private Long filmId;

	@NotNull(message = "Compila il campo vuoto")
	private Long salaId;

	@NotNull(message = "Compila il campo vuoto")
	private LocalDate data;

	@NotNull(message = "Compila il campo vuoto")
	private LocalTime ora;

	public Long getFestivalId() {
		return festivalId;
	}

	public void setFestivalId(Long festivalId) {
		this.festivalId = festivalId;
	}

	public Long getFilmId() {
		return filmId;
	}

	public void setFilmId(Long filmId) {
		this.filmId = filmId;
	}

	public Long getSalaId() {
		return salaId;
	}

	public void setSalaId(Long salaId) {
		this.salaId = salaId;
	}

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
}
