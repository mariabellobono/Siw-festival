package it.uniroma3.siw.dto;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

import it.uniroma3.siw.validation.NotFutureYear;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import jakarta.validation.constraints.Size;

// Tutti gli oggetti che viaggiano nell'API REST (il JSON) stanno qui, in un solo file.
// Perche' DTO e non le entita': le entita' hanno liste che si richiamano a vicenda
// (Film -> Festival -> Film ...) e il JSON andrebbe in ciclo infinito; inoltre toccherebbero
// collezioni LAZY fuori dalla transazione. Un DTO contiene solo i campi che vogliamo mostrare.
// Un "record" e' una classe immutabile con costruttore, getter, equals e toString gia' pronti.
public final class ApiDto {

	private ApiDto() {
	}

	// ---------- RISPOSTE (cosa esce dall'API) ----------

	public record FilmDto(Long id, String titolo, Integer anno, Integer durata, String genere,
			String paeseProduzione, String regista) {
	}

	public record FestivalSintesiDto(Long id, String nome, Integer anno) {
	}

	// Dettaglio: in piu' la media dei voti, il numero di recensioni e i festival a cui partecipa
	public record FilmDettaglioDto(Long id, String titolo, Integer anno, Integer durata, String genere,
			String paeseProduzione, String regista, Double mediaVoti, long numeroRecensioni,
			List<FestivalSintesiDto> festival) {
	}

	public record FestivalDto(Long id, String nome, Integer anno, String citta, LocalDate dataInizio,
			LocalDate dataFine, String descrizione) {
	}

	public record SalaDto(Long id, String nome, String indirizzo, Integer capienza) {
	}

	public record ProiezioneDto(Long id, LocalDate data, LocalTime ora, String stato, Long festivalId,
			String festivalNome, Long filmId, String filmTitolo, Long salaId, String salaNome) {
	}

	public record RecensioneDto(Long id, String testo, Integer voto, LocalDate data, Long filmId, Long utenteId,
			String autore) {
	}

	// Risposta di /api/auth/me: chi e' collegato (authenticated=false se nessuno)
	public record UtenteCorrenteDto(boolean authenticated, String username, Long utenteId, String nome,
			boolean admin) {
	}

	// Una pagina di risultati (paginazione): pagina parte da 0
	public record PaginaDto<T>(List<T> contenuto, int pagina, int dimensione, long totaleElementi,
			int totalePagine) {
	}

	// Formato unico degli errori: status HTTP, titolo, messaggio e (per la validazione) campo -> messaggio
	public record ErroreDto(int status, String errore, String messaggio, java.util.Map<String, String> campi) {
	}

	// ---------- RICHIESTE (cosa entra nell'API) ----------
	// Le annotazioni di validazione sono le stesse delle entita' e dei moduli del sito.

	public record LoginRequest(@NotBlank(message = "Compila il campo vuoto") String username,
			@NotBlank(message = "Compila il campo vuoto") String password) {
	}

	public record FilmRequest(
			@NotBlank(message = "Compila il campo vuoto") String titolo,
			@NotNull(message = "Compila il campo vuoto") @Min(value = 1895, message = "Anno non valido") @NotFutureYear Integer anno,
			@NotNull(message = "Compila il campo vuoto") @Min(value = 1, message = "La durata deve essere di almeno 1 minuto") Integer durata,
			@NotBlank(message = "Compila il campo vuoto") String genere,
			@NotBlank(message = "Compila il campo vuoto") String paeseProduzione,
			@NotBlank(message = "Compila il campo vuoto") String regista) {
	}

	public record FestivalRequest(
			@NotBlank(message = "Compila il campo vuoto") String nome,
			@NotNull(message = "Compila il campo vuoto") @Min(value = 1900, message = "Anno non valido") Integer anno,
			@NotBlank(message = "Compila il campo vuoto") String citta,
			@NotNull(message = "Compila il campo vuoto") LocalDate dataInizio,
			@NotNull(message = "Compila il campo vuoto") LocalDate dataFine,
			String descrizione) {
	}

	public record SalaRequest(
			@NotBlank(message = "Compila il campo vuoto") String nome,
			@NotBlank(message = "Compila il campo vuoto") String indirizzo,
			@NotNull(message = "Compila il campo vuoto") @Positive(message = "La capienza deve essere maggiore di 0") Integer capienza) {
	}

	public record RecensioneRequest(
			@NotBlank(message = "Compila il campo vuoto") @Size(max = 255, message = "Massimo 255 caratteri") String testo,
			@NotNull(message = "Compila il campo vuoto") @Min(value = 1, message = "Il voto deve essere compreso tra 1 e 5") @jakarta.validation.constraints.Max(value = 5, message = "Il voto deve essere compreso tra 1 e 5") Integer voto) {
	}
}
