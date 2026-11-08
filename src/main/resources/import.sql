
-- ==========================================================================
-- DATI DI PROVA - Siw-festival (PostgreSQL)
-- Eseguito da Hibernate all'avvio perche' spring.jpa.hibernate.ddl-auto=create.
-- REGOLE: una istruzione per riga (niente a-capo dentro un insert); commenti con '--'.
-- Le validazioni Java NON si applicano qui (e' SQL diretto): i dati sono coerenti a mano.
-- I caratteri accentati sono scritti come U&'...\00e0' (escape Unicode di PostgreSQL)
-- cosi' il file resta ASCII e non dipende dalla codifica del sistema.
-- Film: reali (durate indicative, variano a seconda della versione).
-- Festival e sale: INVENTATI, solo per test.
-- Riferimento temporale: oggi = 2026-11-03 (passati < oggi, presenti = in corso, futuri > oggi).
-- Ordine: 1 festival, 2 film, 3 film_festival, 4 sale, 5 proiezioni.
-- ==========================================================================

-- ==========================================================================
-- 1. FESTIVAL (8): 3 passati, 2 in corso, 3 futuri
-- ==========================================================================

-- Festival PASSATI
insert into festival (id, nome, anno, citta, data_inizio, data_fine, descrizione, immagine) values (nextval('festival_seq'), 'Troisi Festival', 2025, 'Roma', '2025-09-18', '2025-09-23', 'Omaggio artistico al cinema agrodolce di Massimo Troisi', 'poltrona.svg');
insert into festival (id, nome, anno, citta, data_inizio, data_fine, descrizione, immagine) values (nextval('festival_seq'), 'Torino Cinema Classico', 2024, 'Torino', '2024-11-05', '2024-11-10', 'Rassegna dei capolavori del cinema italiano del dopoguerra e del boom', 'pellicola.svg');
insert into festival (id, nome, anno, citta, data_inizio, data_fine, descrizione, immagine) values (nextval('festival_seq'), 'Festival dei Maestri del Cinema', 2026, 'Bologna', '2026-03-12', '2026-03-18', 'I grandi maestri della regia internazionale, dal muto agli anni Settanta', 'clacchetta.svg');

-- Festival PRESENTI (in corso)
insert into festival (id, nome, anno, citta, data_inizio, data_fine, descrizione, immagine) values (nextval('festival_seq'), 'Cinema in Laguna', 2026, 'Venezia', '2026-10-29', '2026-11-05', 'Il grande cinema d''autore di tutto il mondo sulle rive della laguna', 'stella.svg');
insert into festival (id, nome, anno, citta, data_inizio, data_fine, descrizione, immagine) values (nextval('festival_seq'), 'Napoli Film Days', 2026, 'Napoli', '2026-11-01', '2026-11-08', 'Otto giorni di cinema italiano, tra Napoli, commedia e racconto civile', 'poltrona.svg');

-- Festival FUTURI
insert into festival (id, nome, anno, citta, data_inizio, data_fine, descrizione, immagine) values (nextval('festival_seq'), 'Torino Notte Nera', 2027, 'Torino', '2027-01-20', '2027-01-26', 'Una settimana di noir, thriller e suspense', 'pellicola.svg');
insert into festival (id, nome, anno, citta, data_inizio, data_fine, descrizione, immagine) values (nextval('festival_seq'), 'Fellini Cinema Award', 2027, 'Rimini', '2027-04-14', '2027-04-20', 'Opere che sfidano il realismo per esplorare il sogno', 'stella.svg');
insert into festival (id, nome, anno, citta, data_inizio, data_fine, descrizione, immagine) values (nextval('festival_seq'), 'Roma Classic Cinema', 2027, 'Roma', '2027-06-10', '2027-06-16', 'I classici che hanno fatto la storia del cinema, tra western, kolossal e commedia', 'clacchetta.svg');

-- ==========================================================================
-- 2. FILM (42 film reali, ciascuno inserito una volta sola)
-- Colonne: titolo, anno, durata (minuti), genere, paese_produzione, regista.
-- ==========================================================================
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Ricomincio da tre', 1981, 107, 'Commedia', 'Italia', 'Massimo Troisi');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Il postino', 1994, 108, 'Drammatico', 'Italia', 'Michael Radford');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), U&'La vita \00e8 bella', 1997, 116, 'Commedia drammatica', 'Italia', 'Roberto Benigni');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Il sorpasso', 1962, 108, 'Commedia', 'Italia', 'Dino Risi');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Perfetti sconosciuti', 2016, 97, 'Commedia', 'Italia', 'Paolo Genovese');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Nuovo Cinema Paradiso', 1988, 124, 'Drammatico', 'Italia', 'Giuseppe Tornatore');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Amarcord', 1973, 123, 'Commedia drammatica', 'Italia', 'Federico Fellini');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'La grande bellezza', 2013, 142, 'Drammatico', 'Italia', 'Paolo Sorrentino');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), U&'\00c8 stata la mano di Dio', 2021, 130, 'Drammatico', 'Italia', 'Paolo Sorrentino');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Ladri di biciclette', 1948, 89, 'Drammatico', 'Italia', 'Vittorio De Sica');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), U&'Roma citt\00e0 aperta', 1945, 103, 'Drammatico', 'Italia', 'Roberto Rossellini');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'La strada', 1954, 108, 'Drammatico', 'Italia', 'Federico Fellini');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'La dolce vita', 1960, 174, 'Drammatico', 'Italia', 'Federico Fellini');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Otto e mezzo', 1963, 138, 'Drammatico', 'Italia', 'Federico Fellini');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Il Gattopardo', 1963, 187, 'Storico', 'Italia', 'Luchino Visconti');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Il conformista', 1970, 113, 'Drammatico', 'Italia', 'Bernardo Bertolucci');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Il buono, il brutto, il cattivo', 1966, 161, 'Western', 'Italia', 'Sergio Leone');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'C''era una volta il West', 1968, 165, 'Western', 'Italia', 'Sergio Leone');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Profondo rosso', 1975, 126, 'Giallo', 'Italia', 'Dario Argento');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Gomorra', 2008, 137, 'Drammatico', 'Italia', 'Matteo Garrone');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Il traditore', 2019, 151, 'Biografico', 'Italia', 'Marco Bellocchio');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Quarto potere', 1941, 119, 'Drammatico', 'Stati Uniti', 'Orson Welles');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Casablanca', 1942, 102, 'Drammatico', 'Stati Uniti', 'Michael Curtiz');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'La finestra sul cortile', 1954, 112, 'Thriller', 'Stati Uniti', 'Alfred Hitchcock');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Psyco', 1960, 109, 'Thriller', 'Stati Uniti', 'Alfred Hitchcock');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Il Padrino', 1972, 175, 'Gangster', 'Stati Uniti', 'Francis Ford Coppola');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Taxi Driver', 1976, 114, 'Drammatico', 'Stati Uniti', 'Martin Scorsese');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Il silenzio degli innocenti', 1991, 118, 'Thriller', 'Stati Uniti', 'Jonathan Demme');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Pulp Fiction', 1994, 154, 'Gangster', 'Stati Uniti', 'Quentin Tarantino');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Blade Runner', 1982, 117, 'Fantascienza', 'Stati Uniti', 'Ridley Scott');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Metropolis', 1927, 153, 'Fantascienza', 'Germania', 'Fritz Lang');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), U&'M - Il mostro di D\00fcsseldorf', 1931, 117, 'Thriller', 'Germania', 'Fritz Lang');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Il cielo sopra Berlino', 1987, 128, 'Fantastico', 'Germania', 'Wim Wenders');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Persona', 1966, 83, 'Drammatico', 'Svezia', 'Ingmar Bergman');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Il settimo sigillo', 1957, 96, 'Drammatico', 'Svezia', 'Ingmar Bergman');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Rashomon', 1950, 88, 'Drammatico', 'Giappone', 'Akira Kurosawa');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'I sette samurai', 1954, 207, 'Avventura', 'Giappone', 'Akira Kurosawa');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Viaggio a Tokyo', 1953, 136, 'Drammatico', 'Giappone', 'Yasujiro Ozu');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'I 400 colpi', 1959, 99, 'Drammatico', 'Francia', 'Francois Truffaut');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Fino all''ultimo respiro', 1960, 90, 'Noir', 'Francia', 'Jean-Luc Godard');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), U&'Il favoloso mondo di Am\00e9lie', 2001, 122, 'Commedia', 'Francia', 'Jean-Pierre Jeunet');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Parasite', 2019, 132, 'Thriller', 'Corea del Sud', 'Bong Joon-ho');

-- ==========================================================================
-- 3. ASSOCIAZIONE FILM - FESTIVAL (N-N, 10 film per festival, alcuni film in piu' festival)
-- Tabella di join film_festival(festival_id, films_id): cerco gli id per nome/titolo.
-- ==========================================================================

-- Troisi Festival (2025, Roma)
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Troisi Festival' and film.titolo = 'Ricomincio da tre';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Troisi Festival' and film.titolo = 'Il postino';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Troisi Festival' and film.titolo = U&'La vita \00e8 bella';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Troisi Festival' and film.titolo = 'Il sorpasso';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Troisi Festival' and film.titolo = 'Perfetti sconosciuti';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Troisi Festival' and film.titolo = 'Nuovo Cinema Paradiso';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Troisi Festival' and film.titolo = 'Amarcord';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Troisi Festival' and film.titolo = 'La grande bellezza';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Troisi Festival' and film.titolo = U&'\00c8 stata la mano di Dio';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Troisi Festival' and film.titolo = 'Ladri di biciclette';

-- Torino Cinema Classico (2024, Torino)
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Torino Cinema Classico' and film.titolo = U&'Roma citt\00e0 aperta';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Torino Cinema Classico' and film.titolo = 'Ladri di biciclette';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Torino Cinema Classico' and film.titolo = 'La strada';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Torino Cinema Classico' and film.titolo = 'La dolce vita';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Torino Cinema Classico' and film.titolo = 'Otto e mezzo';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Torino Cinema Classico' and film.titolo = 'Il Gattopardo';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Torino Cinema Classico' and film.titolo = 'Il sorpasso';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Torino Cinema Classico' and film.titolo = 'Il conformista';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Torino Cinema Classico' and film.titolo = 'Amarcord';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Torino Cinema Classico' and film.titolo = 'Il buono, il brutto, il cattivo';

-- Festival dei Maestri del Cinema (2026, Bologna)
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Festival dei Maestri del Cinema' and film.titolo = 'Quarto potere';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Festival dei Maestri del Cinema' and film.titolo = 'Casablanca';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Festival dei Maestri del Cinema' and film.titolo = 'La finestra sul cortile';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Festival dei Maestri del Cinema' and film.titolo = 'Psyco';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Festival dei Maestri del Cinema' and film.titolo = 'Il Padrino';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Festival dei Maestri del Cinema' and film.titolo = 'Taxi Driver';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Festival dei Maestri del Cinema' and film.titolo = 'Metropolis';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Festival dei Maestri del Cinema' and film.titolo = U&'M - Il mostro di D\00fcsseldorf';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Festival dei Maestri del Cinema' and film.titolo = 'Persona';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Festival dei Maestri del Cinema' and film.titolo = 'Il settimo sigillo';

-- Cinema in Laguna (2026, Venezia)
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Cinema in Laguna' and film.titolo = 'Rashomon';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Cinema in Laguna' and film.titolo = 'I sette samurai';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Cinema in Laguna' and film.titolo = 'Viaggio a Tokyo';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Cinema in Laguna' and film.titolo = 'Il settimo sigillo';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Cinema in Laguna' and film.titolo = 'Persona';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Cinema in Laguna' and film.titolo = 'I 400 colpi';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Cinema in Laguna' and film.titolo = 'Fino all''ultimo respiro';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Cinema in Laguna' and film.titolo = 'Il cielo sopra Berlino';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Cinema in Laguna' and film.titolo = 'Parasite';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Cinema in Laguna' and film.titolo = 'La grande bellezza';

-- Napoli Film Days (2026, Napoli)
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Napoli Film Days' and film.titolo = 'Gomorra';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Napoli Film Days' and film.titolo = 'Il traditore';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Napoli Film Days' and film.titolo = U&'\00c8 stata la mano di Dio';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Napoli Film Days' and film.titolo = 'Perfetti sconosciuti';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Napoli Film Days' and film.titolo = 'Ricomincio da tre';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Napoli Film Days' and film.titolo = 'Il postino';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Napoli Film Days' and film.titolo = U&'La vita \00e8 bella';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Napoli Film Days' and film.titolo = 'Nuovo Cinema Paradiso';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Napoli Film Days' and film.titolo = 'Il sorpasso';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Napoli Film Days' and film.titolo = 'Parasite';

-- Torino Notte Nera (2027, Torino)
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Torino Notte Nera' and film.titolo = 'Psyco';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Torino Notte Nera' and film.titolo = 'La finestra sul cortile';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Torino Notte Nera' and film.titolo = 'Il silenzio degli innocenti';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Torino Notte Nera' and film.titolo = 'Profondo rosso';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Torino Notte Nera' and film.titolo = U&'M - Il mostro di D\00fcsseldorf';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Torino Notte Nera' and film.titolo = 'Pulp Fiction';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Torino Notte Nera' and film.titolo = 'Taxi Driver';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Torino Notte Nera' and film.titolo = 'Blade Runner';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Torino Notte Nera' and film.titolo = 'Il conformista';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Torino Notte Nera' and film.titolo = 'Gomorra';

-- Fellini Cinema Award (2027, Rimini)
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Fellini Cinema Award' and film.titolo = 'La dolce vita';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Fellini Cinema Award' and film.titolo = 'Otto e mezzo';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Fellini Cinema Award' and film.titolo = 'Amarcord';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Fellini Cinema Award' and film.titolo = 'La strada';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Fellini Cinema Award' and film.titolo = U&'Il favoloso mondo di Am\00e9lie';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Fellini Cinema Award' and film.titolo = 'Il cielo sopra Berlino';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Fellini Cinema Award' and film.titolo = 'Metropolis';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Fellini Cinema Award' and film.titolo = 'Blade Runner';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Fellini Cinema Award' and film.titolo = 'Persona';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Fellini Cinema Award' and film.titolo = 'La grande bellezza';

-- Roma Classic Cinema (2027, Roma)
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Roma Classic Cinema' and film.titolo = 'Casablanca';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Roma Classic Cinema' and film.titolo = 'Quarto potere';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Roma Classic Cinema' and film.titolo = 'Il Padrino';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Roma Classic Cinema' and film.titolo = 'C''era una volta il West';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Roma Classic Cinema' and film.titolo = 'Il buono, il brutto, il cattivo';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Roma Classic Cinema' and film.titolo = 'Ladri di biciclette';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Roma Classic Cinema' and film.titolo = U&'Roma citt\00e0 aperta';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Roma Classic Cinema' and film.titolo = 'Il Gattopardo';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Roma Classic Cinema' and film.titolo = 'I sette samurai';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Roma Classic Cinema' and film.titolo = 'La dolce vita';

-- ==========================================================================
-- 4. SALE (30 = 5 per citta; i festival della stessa citta condividono le sale)
-- Roma: Troisi Festival + Roma Classic Cinema. Torino: Torino Cinema Classico + Torino Notte Nera.
-- ==========================================================================

-- Sale di Roma
insert into sala (id, nome, indirizzo, capienza) values (nextval('sala_seq'), 'Sala Anna Magnani', 'Via Appia Nuova 120, Roma', 250);
insert into sala (id, nome, indirizzo, capienza) values (nextval('sala_seq'), 'Sala Alberto Sordi', 'Via Nomentana 45, Roma', 180);
insert into sala (id, nome, indirizzo, capienza) values (nextval('sala_seq'), 'Sala Vittorio Gassman', 'Via Tiburtina 210, Roma', 140);
insert into sala (id, nome, indirizzo, capienza) values (nextval('sala_seq'), 'Sala Monica Vitti', 'Viale Trastevere 88, Roma', 100);
insert into sala (id, nome, indirizzo, capienza) values (nextval('sala_seq'), 'Sala Gina Lollobrigida', 'Via Ostiense 15, Roma', 60);

-- Sale di Torino
insert into sala (id, nome, indirizzo, capienza) values (nextval('sala_seq'), 'Sala Cabiria', 'Via Po 20, Torino', 230);
insert into sala (id, nome, indirizzo, capienza) values (nextval('sala_seq'), 'Sala Carlo Lizzani', 'Corso Vittorio Emanuele II 70, Torino', 170);
insert into sala (id, nome, indirizzo, capienza) values (nextval('sala_seq'), 'Sala Franca Valeri', 'Via Garibaldi 33, Torino', 130);
insert into sala (id, nome, indirizzo, capienza) values (nextval('sala_seq'), 'Sala Paolo Villaggio', 'Corso Francia 112, Torino', 90);
insert into sala (id, nome, indirizzo, capienza) values (nextval('sala_seq'), 'Sala Gian Maria Volonte', 'Via Nizza 58, Torino', 70);

-- Sale di Bologna
insert into sala (id, nome, indirizzo, capienza) values (nextval('sala_seq'), 'Sala Pasolini', 'Via Zamboni 25, Bologna', 240);
insert into sala (id, nome, indirizzo, capienza) values (nextval('sala_seq'), 'Sala Antonioni', 'Via Indipendenza 40, Bologna', 160);
insert into sala (id, nome, indirizzo, capienza) values (nextval('sala_seq'), 'Sala Tonino Guerra', 'Via Saragozza 90, Bologna', 120);
insert into sala (id, nome, indirizzo, capienza) values (nextval('sala_seq'), 'Sala Marco Ferreri', 'Via Mazzini 14, Bologna', 95);
insert into sala (id, nome, indirizzo, capienza) values (nextval('sala_seq'), 'Sala Ermanno Olmi', 'Via Stalingrado 60, Bologna', 65);

-- Sale di Venezia
insert into sala (id, nome, indirizzo, capienza) values (nextval('sala_seq'), 'Sala Lido', 'Lungomare Marconi 10, Venezia', 260);
insert into sala (id, nome, indirizzo, capienza) values (nextval('sala_seq'), 'Sala Rialto', 'Campo San Bartolomeo 5, Venezia', 150);
insert into sala (id, nome, indirizzo, capienza) values (nextval('sala_seq'), 'Sala Giudecca', 'Fondamenta della Croce 3, Venezia', 125);
insert into sala (id, nome, indirizzo, capienza) values (nextval('sala_seq'), 'Sala Murano', 'Fondamenta Navagero 8, Venezia', 100);
insert into sala (id, nome, indirizzo, capienza) values (nextval('sala_seq'), 'Sala Dorsoduro', 'Calle Larga 21, Venezia', 55);

-- Sale di Napoli
insert into sala (id, nome, indirizzo, capienza) values (nextval('sala_seq'), 'Sala Toto', 'Via Toledo 100, Napoli', 270);
insert into sala (id, nome, indirizzo, capienza) values (nextval('sala_seq'), 'Sala Eduardo De Filippo', 'Via dei Tribunali 50, Napoli', 190);
insert into sala (id, nome, indirizzo, capienza) values (nextval('sala_seq'), 'Sala Sophia Loren', 'Via Chiaia 70, Napoli', 135);
insert into sala (id, nome, indirizzo, capienza) values (nextval('sala_seq'), 'Sala Massimo Troisi', 'Via Caracciolo 12, Napoli', 110);
insert into sala (id, nome, indirizzo, capienza) values (nextval('sala_seq'), 'Sala Vesuvio', 'Via Partenope 33, Napoli', 75);

-- Sale di Rimini
insert into sala (id, nome, indirizzo, capienza) values (nextval('sala_seq'), 'Sala Fellini', 'Viale Vespucci 3, Rimini', 220);
insert into sala (id, nome, indirizzo, capienza) values (nextval('sala_seq'), 'Sala Giulietta Masina', 'Corso d''Augusto 40, Rimini', 165);
insert into sala (id, nome, indirizzo, capienza) values (nextval('sala_seq'), 'Sala Amarcord', 'Lungomare Tintori 9, Rimini', 120);
insert into sala (id, nome, indirizzo, capienza) values (nextval('sala_seq'), 'Sala Borgo San Giuliano', 'Via Tiberio 17, Rimini', 85);
insert into sala (id, nome, indirizzo, capienza) values (nextval('sala_seq'), 'Sala Marecchia', 'Via Flaminia 200, Rimini', 60);

-- ==========================================================================
-- 5. PROIEZIONI (una per ogni film di ogni festival = 80)
-- Collegano festival + film + sala. Stato: COMPLETED se la data e' passata, SCHEDULED se oggi o futura,
-- CANCELLED per 3 proiezioni di prova. Due slot per sala (18:00 e 21:00), nessuna sala occupata due volte.
-- ==========================================================================

-- Troisi Festival (Roma)
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2025-09-18', '18:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Troisi Festival' and fi.titolo = 'Ricomincio da tre' and sa.nome = 'Sala Anna Magnani';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2025-09-19', '18:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Troisi Festival' and fi.titolo = 'Il postino' and sa.nome = 'Sala Alberto Sordi';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2025-09-20', '18:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Troisi Festival' and fi.titolo = U&'La vita \00e8 bella' and sa.nome = 'Sala Vittorio Gassman';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2025-09-21', '18:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Troisi Festival' and fi.titolo = 'Il sorpasso' and sa.nome = 'Sala Monica Vitti';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2025-09-22', '18:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Troisi Festival' and fi.titolo = 'Perfetti sconosciuti' and sa.nome = 'Sala Gina Lollobrigida';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2025-09-23', '21:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Troisi Festival' and fi.titolo = 'Nuovo Cinema Paradiso' and sa.nome = 'Sala Anna Magnani';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2025-09-18', '21:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Troisi Festival' and fi.titolo = 'Amarcord' and sa.nome = 'Sala Alberto Sordi';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2025-09-19', '21:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Troisi Festival' and fi.titolo = 'La grande bellezza' and sa.nome = 'Sala Vittorio Gassman';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2025-09-20', '21:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Troisi Festival' and fi.titolo = U&'\00c8 stata la mano di Dio' and sa.nome = 'Sala Monica Vitti';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2025-09-21', '21:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Troisi Festival' and fi.titolo = 'Ladri di biciclette' and sa.nome = 'Sala Gina Lollobrigida';

-- Torino Cinema Classico (Torino)
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2024-11-05', '18:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Torino Cinema Classico' and fi.titolo = U&'Roma citt\00e0 aperta' and sa.nome = 'Sala Cabiria';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2024-11-06', '18:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Torino Cinema Classico' and fi.titolo = 'Ladri di biciclette' and sa.nome = 'Sala Carlo Lizzani';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2024-11-07', '18:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Torino Cinema Classico' and fi.titolo = 'La strada' and sa.nome = 'Sala Franca Valeri';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2024-11-08', '18:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Torino Cinema Classico' and fi.titolo = 'La dolce vita' and sa.nome = 'Sala Paolo Villaggio';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2024-11-09', '18:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Torino Cinema Classico' and fi.titolo = 'Otto e mezzo' and sa.nome = 'Sala Gian Maria Volonte';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2024-11-10', '21:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Torino Cinema Classico' and fi.titolo = 'Il Gattopardo' and sa.nome = 'Sala Cabiria';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2024-11-05', '21:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Torino Cinema Classico' and fi.titolo = 'Il sorpasso' and sa.nome = 'Sala Carlo Lizzani';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2024-11-06', '21:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Torino Cinema Classico' and fi.titolo = 'Il conformista' and sa.nome = 'Sala Franca Valeri';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2024-11-07', '21:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Torino Cinema Classico' and fi.titolo = 'Amarcord' and sa.nome = 'Sala Paolo Villaggio';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2024-11-08', '21:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Torino Cinema Classico' and fi.titolo = 'Il buono, il brutto, il cattivo' and sa.nome = 'Sala Gian Maria Volonte';

-- Festival dei Maestri del Cinema (Bologna)
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2026-03-12', '18:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Festival dei Maestri del Cinema' and fi.titolo = 'Quarto potere' and sa.nome = 'Sala Pasolini';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2026-03-13', '18:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Festival dei Maestri del Cinema' and fi.titolo = 'Casablanca' and sa.nome = 'Sala Antonioni';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2026-03-14', '18:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Festival dei Maestri del Cinema' and fi.titolo = 'La finestra sul cortile' and sa.nome = 'Sala Tonino Guerra';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2026-03-15', '18:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Festival dei Maestri del Cinema' and fi.titolo = 'Psyco' and sa.nome = 'Sala Marco Ferreri';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2026-03-16', '18:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Festival dei Maestri del Cinema' and fi.titolo = 'Il Padrino' and sa.nome = 'Sala Ermanno Olmi';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2026-03-17', '21:00:00', 'CANCELLED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Festival dei Maestri del Cinema' and fi.titolo = 'Taxi Driver' and sa.nome = 'Sala Pasolini';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2026-03-18', '21:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Festival dei Maestri del Cinema' and fi.titolo = 'Metropolis' and sa.nome = 'Sala Antonioni';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2026-03-12', '21:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Festival dei Maestri del Cinema' and fi.titolo = U&'M - Il mostro di D\00fcsseldorf' and sa.nome = 'Sala Tonino Guerra';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2026-03-13', '21:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Festival dei Maestri del Cinema' and fi.titolo = 'Persona' and sa.nome = 'Sala Marco Ferreri';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2026-03-14', '21:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Festival dei Maestri del Cinema' and fi.titolo = 'Il settimo sigillo' and sa.nome = 'Sala Ermanno Olmi';

-- Cinema in Laguna (Venezia)
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2026-10-29', '18:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Cinema in Laguna' and fi.titolo = 'Rashomon' and sa.nome = 'Sala Lido';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2026-10-30', '18:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Cinema in Laguna' and fi.titolo = 'I sette samurai' and sa.nome = 'Sala Rialto';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2026-10-31', '18:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Cinema in Laguna' and fi.titolo = 'Viaggio a Tokyo' and sa.nome = 'Sala Giudecca';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2026-11-01', '18:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Cinema in Laguna' and fi.titolo = 'Il settimo sigillo' and sa.nome = 'Sala Murano';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2026-11-02', '18:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Cinema in Laguna' and fi.titolo = 'Persona' and sa.nome = 'Sala Dorsoduro';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2026-11-03', '21:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Cinema in Laguna' and fi.titolo = 'I 400 colpi' and sa.nome = 'Sala Lido';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2026-11-04', '21:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Cinema in Laguna' and fi.titolo = 'Fino all''ultimo respiro' and sa.nome = 'Sala Rialto';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2026-11-05', '21:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Cinema in Laguna' and fi.titolo = 'Il cielo sopra Berlino' and sa.nome = 'Sala Giudecca';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2026-10-29', '21:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Cinema in Laguna' and fi.titolo = 'Parasite' and sa.nome = 'Sala Murano';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2026-10-30', '21:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Cinema in Laguna' and fi.titolo = 'La grande bellezza' and sa.nome = 'Sala Dorsoduro';

-- Napoli Film Days (Napoli)
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2026-11-01', '18:00:00', 'CANCELLED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Napoli Film Days' and fi.titolo = 'Gomorra' and sa.nome = 'Sala Toto';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2026-11-02', '18:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Napoli Film Days' and fi.titolo = 'Il traditore' and sa.nome = 'Sala Eduardo De Filippo';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2026-11-03', '18:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Napoli Film Days' and fi.titolo = U&'\00c8 stata la mano di Dio' and sa.nome = 'Sala Sophia Loren';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2026-11-04', '18:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Napoli Film Days' and fi.titolo = 'Perfetti sconosciuti' and sa.nome = 'Sala Massimo Troisi';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2026-11-05', '18:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Napoli Film Days' and fi.titolo = 'Ricomincio da tre' and sa.nome = 'Sala Vesuvio';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2026-11-06', '21:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Napoli Film Days' and fi.titolo = 'Il postino' and sa.nome = 'Sala Toto';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2026-11-07', '21:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Napoli Film Days' and fi.titolo = U&'La vita \00e8 bella' and sa.nome = 'Sala Eduardo De Filippo';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2026-11-08', '21:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Napoli Film Days' and fi.titolo = 'Nuovo Cinema Paradiso' and sa.nome = 'Sala Sophia Loren';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2026-11-01', '21:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Napoli Film Days' and fi.titolo = 'Il sorpasso' and sa.nome = 'Sala Massimo Troisi';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2026-11-02', '21:00:00', 'COMPLETED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Napoli Film Days' and fi.titolo = 'Parasite' and sa.nome = 'Sala Vesuvio';

-- Torino Notte Nera (Torino)
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2027-01-20', '18:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Torino Notte Nera' and fi.titolo = 'Psyco' and sa.nome = 'Sala Cabiria';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2027-01-21', '18:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Torino Notte Nera' and fi.titolo = 'La finestra sul cortile' and sa.nome = 'Sala Carlo Lizzani';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2027-01-22', '18:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Torino Notte Nera' and fi.titolo = 'Il silenzio degli innocenti' and sa.nome = 'Sala Franca Valeri';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2027-01-23', '18:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Torino Notte Nera' and fi.titolo = 'Profondo rosso' and sa.nome = 'Sala Paolo Villaggio';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2027-01-24', '18:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Torino Notte Nera' and fi.titolo = U&'M - Il mostro di D\00fcsseldorf' and sa.nome = 'Sala Gian Maria Volonte';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2027-01-25', '21:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Torino Notte Nera' and fi.titolo = 'Pulp Fiction' and sa.nome = 'Sala Cabiria';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2027-01-26', '21:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Torino Notte Nera' and fi.titolo = 'Taxi Driver' and sa.nome = 'Sala Carlo Lizzani';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2027-01-20', '21:00:00', 'CANCELLED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Torino Notte Nera' and fi.titolo = 'Blade Runner' and sa.nome = 'Sala Franca Valeri';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2027-01-21', '21:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Torino Notte Nera' and fi.titolo = 'Il conformista' and sa.nome = 'Sala Paolo Villaggio';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2027-01-22', '21:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Torino Notte Nera' and fi.titolo = 'Gomorra' and sa.nome = 'Sala Gian Maria Volonte';

-- Fellini Cinema Award (Rimini)
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2027-04-14', '18:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Fellini Cinema Award' and fi.titolo = 'La dolce vita' and sa.nome = 'Sala Fellini';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2027-04-15', '18:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Fellini Cinema Award' and fi.titolo = 'Otto e mezzo' and sa.nome = 'Sala Giulietta Masina';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2027-04-16', '18:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Fellini Cinema Award' and fi.titolo = 'Amarcord' and sa.nome = 'Sala Amarcord';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2027-04-17', '18:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Fellini Cinema Award' and fi.titolo = 'La strada' and sa.nome = 'Sala Borgo San Giuliano';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2027-04-18', '18:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Fellini Cinema Award' and fi.titolo = U&'Il favoloso mondo di Am\00e9lie' and sa.nome = 'Sala Marecchia';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2027-04-19', '21:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Fellini Cinema Award' and fi.titolo = 'Il cielo sopra Berlino' and sa.nome = 'Sala Fellini';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2027-04-20', '21:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Fellini Cinema Award' and fi.titolo = 'Metropolis' and sa.nome = 'Sala Giulietta Masina';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2027-04-14', '21:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Fellini Cinema Award' and fi.titolo = 'Blade Runner' and sa.nome = 'Sala Amarcord';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2027-04-15', '21:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Fellini Cinema Award' and fi.titolo = 'Persona' and sa.nome = 'Sala Borgo San Giuliano';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2027-04-16', '21:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Fellini Cinema Award' and fi.titolo = 'La grande bellezza' and sa.nome = 'Sala Marecchia';

-- Roma Classic Cinema (Roma)
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2027-06-10', '18:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Roma Classic Cinema' and fi.titolo = 'Casablanca' and sa.nome = 'Sala Anna Magnani';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2027-06-11', '18:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Roma Classic Cinema' and fi.titolo = 'Quarto potere' and sa.nome = 'Sala Alberto Sordi';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2027-06-12', '18:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Roma Classic Cinema' and fi.titolo = 'Il Padrino' and sa.nome = 'Sala Vittorio Gassman';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2027-06-13', '18:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Roma Classic Cinema' and fi.titolo = 'C''era una volta il West' and sa.nome = 'Sala Monica Vitti';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2027-06-14', '18:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Roma Classic Cinema' and fi.titolo = 'Il buono, il brutto, il cattivo' and sa.nome = 'Sala Gina Lollobrigida';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2027-06-15', '21:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Roma Classic Cinema' and fi.titolo = 'Ladri di biciclette' and sa.nome = 'Sala Anna Magnani';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2027-06-16', '21:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Roma Classic Cinema' and fi.titolo = U&'Roma citt\00e0 aperta' and sa.nome = 'Sala Alberto Sordi';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2027-06-10', '21:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Roma Classic Cinema' and fi.titolo = 'Il Gattopardo' and sa.nome = 'Sala Vittorio Gassman';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2027-06-11', '21:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Roma Classic Cinema' and fi.titolo = 'I sette samurai' and sa.nome = 'Sala Monica Vitti';
insert into proiezione (id, data, ora, stato, festival_id, film_id, sala_id) select nextval('proiezione_seq'), '2027-06-12', '21:00:00', 'SCHEDULED', fe.id, fi.id, sa.id from festival fe, film fi, sala sa where fe.nome = 'Roma Classic Cinema' and fi.titolo = 'La dolce vita' and sa.nome = 'Sala Gina Lollobrigida';


-- UTENTI E CREDENZIALI (password: admin / utente1, cifrate con BCrypt)
insert into utente (id, nome, cognome, email) values (nextval('utente_seq'), 'Admin', 'Sistema', 'admin@festival.it');
insert into utente (id, nome, cognome, email) values (nextval('utente_seq'), 'Mario', 'Rossi', 'mario.rossi@festival.it');
insert into credenziali (id, username, password, ruolo, utente_id) select nextval('credenziali_seq'), 'admin', '$2b$10$BT78ZlJ2AQkzxOcn1TLNUeaMzM4IjDmo8I/OzcYZZn0pHhhMRjp6W', 'ADMIN', u.id from utente u where u.email = 'admin@festival.it';
insert into credenziali (id, username, password, ruolo, utente_id) select nextval('credenziali_seq'), 'utente1', '$2b$10$/.knpi7r/Ox4zdNfX20dDej5upc9YkPUPKB.gVnjQvgRYtTlq/TYK', 'USER', u.id from utente u where u.email = 'mario.rossi@festival.it';
-- ==========================================================================
-- 6. ATTORI E INTERPRETAZIONI (attori reali; un attore compare in piu' film)
-- interpretazione = un attore interpreta un personaggio in un film.
-- Il film si cerca con (regista, anno), che nei dati di prova e' univoco.
-- ==========================================================================

-- Attori (77)
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Massimo', 'Troisi', '1953-02-19', 'Italia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Lello', 'Arena', '1953-08-06', 'Italia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Philippe', 'Noiret', '1930-10-01', 'Francia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Maria Grazia', 'Cucinotta', '1968-07-23', 'Italia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Roberto', 'Benigni', '1952-10-27', 'Italia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Nicoletta', 'Braschi', '1960-04-19', 'Italia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Vittorio', 'Gassman', '1922-09-01', 'Italia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Jean-Louis', 'Trintignant', '1930-12-11', 'Francia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Marco', 'Giallini', '1963-06-14', 'Italia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Valerio', 'Mastandrea', '1972-02-14', 'Italia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Jacques', 'Perrin', '1941-07-13', 'Francia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Magali', U&'No\00ebl', '1931-06-27', 'Francia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Pupella', 'Maggio', '1910-04-24', 'Italia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Toni', 'Servillo', '1959-01-25', 'Italia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Carlo', 'Verdone', '1950-11-17', 'Italia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Sabrina', 'Ferilli', '1964-06-28', 'Italia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Lamberto', 'Maggiorani', '1909-08-28', 'Italia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Enzo', 'Staiola', '1939-10-15', 'Italia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Anna', 'Magnani', '1908-03-07', 'Italia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Aldo', 'Fabrizi', '1905-11-01', 'Italia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Giulietta', 'Masina', '1921-02-22', 'Italia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Anthony', 'Quinn', '1915-04-21', 'Stati Uniti');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Marcello', 'Mastroianni', '1924-09-28', 'Italia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Anita', 'Ekberg', '1931-09-29', 'Svezia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Claudia', 'Cardinale', '1938-04-15', 'Italia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Burt', 'Lancaster', '1913-11-02', 'Stati Uniti');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Alain', 'Delon', '1935-11-08', 'Francia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Stefania', 'Sandrelli', '1946-06-05', 'Italia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Clint', 'Eastwood', '1930-05-31', 'Stati Uniti');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Eli', 'Wallach', '1915-12-07', 'Stati Uniti');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Lee', 'Van Cleef', '1925-01-09', 'Stati Uniti');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Henry', 'Fonda', '1905-05-16', 'Stati Uniti');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Charles', 'Bronson', '1921-11-03', 'Stati Uniti');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'David', 'Hemmings', '1941-11-18', 'Regno Unito');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Daria', 'Nicolodi', '1950-06-19', 'Italia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Pierfrancesco', 'Favino', '1969-08-24', 'Italia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Luigi', 'Lo Cascio', '1967-10-20', 'Italia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Orson', 'Welles', '1915-05-06', 'Stati Uniti');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Joseph', 'Cotten', '1905-05-15', 'Stati Uniti');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Humphrey', 'Bogart', '1899-12-25', 'Stati Uniti');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Ingrid', 'Bergman', '1915-08-29', 'Svezia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'James', 'Stewart', '1908-05-20', 'Stati Uniti');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Grace', 'Kelly', '1929-11-12', 'Stati Uniti');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Anthony', 'Perkins', '1932-04-04', 'Stati Uniti');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Janet', 'Leigh', '1927-07-06', 'Stati Uniti');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Marlon', 'Brando', '1924-04-03', 'Stati Uniti');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Al', 'Pacino', '1940-04-25', 'Stati Uniti');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'James', 'Caan', '1940-03-26', 'Stati Uniti');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Robert', 'De Niro', '1943-08-17', 'Stati Uniti');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Jodie', 'Foster', '1962-11-19', 'Stati Uniti');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Anthony', 'Hopkins', '1937-12-31', 'Regno Unito');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'John', 'Travolta', '1954-02-18', 'Stati Uniti');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Samuel L.', 'Jackson', '1948-12-21', 'Stati Uniti');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Uma', 'Thurman', '1970-04-29', 'Stati Uniti');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Harrison', 'Ford', '1942-07-13', 'Stati Uniti');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Rutger', 'Hauer', '1944-01-23', 'Paesi Bassi');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Brigitte', 'Helm', '1906-03-17', 'Germania');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Alfred', 'Abel', '1879-05-12', 'Germania');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Peter', 'Lorre', '1904-06-26', 'Ungheria');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Bruno', 'Ganz', '1941-03-22', 'Svizzera');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Peter', 'Falk', '1927-09-16', 'Stati Uniti');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Bibi', 'Andersson', '1935-11-11', 'Svezia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Liv', 'Ullmann', '1938-12-16', 'Norvegia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Max', 'von Sydow', '1929-04-10', 'Svezia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Gunnar', U&'Bj\00f6rnstrand', '1909-11-13', 'Svezia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Toshiro', 'Mifune', '1920-04-01', 'Giappone');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Machiko', U&'Ky\014d', '1924-03-25', 'Giappone');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Takashi', 'Shimura', '1905-03-12', 'Giappone');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), U&'Chish\016b', U&'Ry\016b', '1904-05-13', 'Giappone');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Setsuko', 'Hara', '1920-06-17', 'Giappone');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Jean-Pierre', U&'L\00e9aud', '1944-05-05', 'Francia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Jean-Paul', 'Belmondo', '1933-04-09', 'Francia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Jean', 'Seberg', '1938-11-13', 'Stati Uniti');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Audrey', 'Tautou', '1976-08-09', 'Francia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Mathieu', 'Kassovitz', '1967-08-03', 'Francia');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Kang-ho', 'Song', '1967-01-17', 'Corea del Sud');
insert into attore (id, nome, cognome, data_nascita, nazionalita) values (nextval('attore_seq'), 'Woo-shik', 'Choi', '1990-03-26', 'Corea del Sud');

-- Interpretazioni (87)
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Gaetano', fi.id, at.id from film fi, attore at where fi.regista = 'Massimo Troisi' and fi.anno = 1981 and at.nome = 'Massimo' and at.cognome = 'Troisi';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Robertino', fi.id, at.id from film fi, attore at where fi.regista = 'Massimo Troisi' and fi.anno = 1981 and at.nome = 'Lello' and at.cognome = 'Arena';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Mario Ruoppolo', fi.id, at.id from film fi, attore at where fi.regista = 'Michael Radford' and fi.anno = 1994 and at.nome = 'Massimo' and at.cognome = 'Troisi';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Pablo Neruda', fi.id, at.id from film fi, attore at where fi.regista = 'Michael Radford' and fi.anno = 1994 and at.nome = 'Philippe' and at.cognome = 'Noiret';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Beatrice Russo', fi.id, at.id from film fi, attore at where fi.regista = 'Michael Radford' and fi.anno = 1994 and at.nome = 'Maria Grazia' and at.cognome = 'Cucinotta';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Guido Orefice', fi.id, at.id from film fi, attore at where fi.regista = 'Roberto Benigni' and fi.anno = 1997 and at.nome = 'Roberto' and at.cognome = 'Benigni';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Dora', fi.id, at.id from film fi, attore at where fi.regista = 'Roberto Benigni' and fi.anno = 1997 and at.nome = 'Nicoletta' and at.cognome = 'Braschi';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Bruno Cortona', fi.id, at.id from film fi, attore at where fi.regista = 'Dino Risi' and fi.anno = 1962 and at.nome = 'Vittorio' and at.cognome = 'Gassman';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Roberto Mariani', fi.id, at.id from film fi, attore at where fi.regista = 'Dino Risi' and fi.anno = 1962 and at.nome = 'Jean-Louis' and at.cognome = 'Trintignant';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Rocco', fi.id, at.id from film fi, attore at where fi.regista = 'Paolo Genovese' and fi.anno = 2016 and at.nome = 'Marco' and at.cognome = 'Giallini';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Lele', fi.id, at.id from film fi, attore at where fi.regista = 'Paolo Genovese' and fi.anno = 2016 and at.nome = 'Valerio' and at.cognome = 'Mastandrea';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Alfredo', fi.id, at.id from film fi, attore at where fi.regista = 'Giuseppe Tornatore' and fi.anno = 1988 and at.nome = 'Philippe' and at.cognome = 'Noiret';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Salvatore Di Vita', fi.id, at.id from film fi, attore at where fi.regista = 'Giuseppe Tornatore' and fi.anno = 1988 and at.nome = 'Jacques' and at.cognome = 'Perrin';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'La Gradisca', fi.id, at.id from film fi, attore at where fi.regista = 'Federico Fellini' and fi.anno = 1973 and at.nome = 'Magali' and at.cognome = U&'No\00ebl';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Miranda', fi.id, at.id from film fi, attore at where fi.regista = 'Federico Fellini' and fi.anno = 1973 and at.nome = 'Pupella' and at.cognome = 'Maggio';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Jep Gambardella', fi.id, at.id from film fi, attore at where fi.regista = 'Paolo Sorrentino' and fi.anno = 2013 and at.nome = 'Toni' and at.cognome = 'Servillo';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Romano', fi.id, at.id from film fi, attore at where fi.regista = 'Paolo Sorrentino' and fi.anno = 2013 and at.nome = 'Carlo' and at.cognome = 'Verdone';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Ramona', fi.id, at.id from film fi, attore at where fi.regista = 'Paolo Sorrentino' and fi.anno = 2013 and at.nome = 'Sabrina' and at.cognome = 'Ferilli';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Antonio Capuano', fi.id, at.id from film fi, attore at where fi.regista = 'Paolo Sorrentino' and fi.anno = 2021 and at.nome = 'Toni' and at.cognome = 'Servillo';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Antonio Ricci', fi.id, at.id from film fi, attore at where fi.regista = 'Vittorio De Sica' and fi.anno = 1948 and at.nome = 'Lamberto' and at.cognome = 'Maggiorani';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Bruno Ricci', fi.id, at.id from film fi, attore at where fi.regista = 'Vittorio De Sica' and fi.anno = 1948 and at.nome = 'Enzo' and at.cognome = 'Staiola';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Pina', fi.id, at.id from film fi, attore at where fi.regista = 'Roberto Rossellini' and fi.anno = 1945 and at.nome = 'Anna' and at.cognome = 'Magnani';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Don Pietro Pellegrini', fi.id, at.id from film fi, attore at where fi.regista = 'Roberto Rossellini' and fi.anno = 1945 and at.nome = 'Aldo' and at.cognome = 'Fabrizi';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Gelsomina', fi.id, at.id from film fi, attore at where fi.regista = 'Federico Fellini' and fi.anno = 1954 and at.nome = 'Giulietta' and at.cognome = 'Masina';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), U&'Zampan\00f2', fi.id, at.id from film fi, attore at where fi.regista = 'Federico Fellini' and fi.anno = 1954 and at.nome = 'Anthony' and at.cognome = 'Quinn';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Marcello Rubini', fi.id, at.id from film fi, attore at where fi.regista = 'Federico Fellini' and fi.anno = 1960 and at.nome = 'Marcello' and at.cognome = 'Mastroianni';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Sylvia', fi.id, at.id from film fi, attore at where fi.regista = 'Federico Fellini' and fi.anno = 1960 and at.nome = 'Anita' and at.cognome = 'Ekberg';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Guido Anselmi', fi.id, at.id from film fi, attore at where fi.regista = 'Federico Fellini' and fi.anno = 1963 and at.nome = 'Marcello' and at.cognome = 'Mastroianni';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Claudia', fi.id, at.id from film fi, attore at where fi.regista = 'Federico Fellini' and fi.anno = 1963 and at.nome = 'Claudia' and at.cognome = 'Cardinale';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Don Fabrizio Salina', fi.id, at.id from film fi, attore at where fi.regista = 'Luchino Visconti' and fi.anno = 1963 and at.nome = 'Burt' and at.cognome = 'Lancaster';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Tancredi Falconeri', fi.id, at.id from film fi, attore at where fi.regista = 'Luchino Visconti' and fi.anno = 1963 and at.nome = 'Alain' and at.cognome = 'Delon';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Angelica Sedara', fi.id, at.id from film fi, attore at where fi.regista = 'Luchino Visconti' and fi.anno = 1963 and at.nome = 'Claudia' and at.cognome = 'Cardinale';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Marcello Clerici', fi.id, at.id from film fi, attore at where fi.regista = 'Bernardo Bertolucci' and fi.anno = 1970 and at.nome = 'Jean-Louis' and at.cognome = 'Trintignant';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Giulia', fi.id, at.id from film fi, attore at where fi.regista = 'Bernardo Bertolucci' and fi.anno = 1970 and at.nome = 'Stefania' and at.cognome = 'Sandrelli';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Il Buono (Biondo)', fi.id, at.id from film fi, attore at where fi.regista = 'Sergio Leone' and fi.anno = 1966 and at.nome = 'Clint' and at.cognome = 'Eastwood';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Il Brutto (Tuco)', fi.id, at.id from film fi, attore at where fi.regista = 'Sergio Leone' and fi.anno = 1966 and at.nome = 'Eli' and at.cognome = 'Wallach';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Il Cattivo (Sentenza)', fi.id, at.id from film fi, attore at where fi.regista = 'Sergio Leone' and fi.anno = 1966 and at.nome = 'Lee' and at.cognome = 'Van Cleef';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Frank', fi.id, at.id from film fi, attore at where fi.regista = 'Sergio Leone' and fi.anno = 1968 and at.nome = 'Henry' and at.cognome = 'Fonda';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Armonica', fi.id, at.id from film fi, attore at where fi.regista = 'Sergio Leone' and fi.anno = 1968 and at.nome = 'Charles' and at.cognome = 'Bronson';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Jill McBain', fi.id, at.id from film fi, attore at where fi.regista = 'Sergio Leone' and fi.anno = 1968 and at.nome = 'Claudia' and at.cognome = 'Cardinale';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Marcus Daly', fi.id, at.id from film fi, attore at where fi.regista = 'Dario Argento' and fi.anno = 1975 and at.nome = 'David' and at.cognome = 'Hemmings';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Gianna Brezzi', fi.id, at.id from film fi, attore at where fi.regista = 'Dario Argento' and fi.anno = 1975 and at.nome = 'Daria' and at.cognome = 'Nicolodi';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Franco', fi.id, at.id from film fi, attore at where fi.regista = 'Matteo Garrone' and fi.anno = 2008 and at.nome = 'Toni' and at.cognome = 'Servillo';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Tommaso Buscetta', fi.id, at.id from film fi, attore at where fi.regista = 'Marco Bellocchio' and fi.anno = 2019 and at.nome = 'Pierfrancesco' and at.cognome = 'Favino';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Totuccio Contorno', fi.id, at.id from film fi, attore at where fi.regista = 'Marco Bellocchio' and fi.anno = 2019 and at.nome = 'Luigi' and at.cognome = 'Lo Cascio';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Charles Foster Kane', fi.id, at.id from film fi, attore at where fi.regista = 'Orson Welles' and fi.anno = 1941 and at.nome = 'Orson' and at.cognome = 'Welles';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Jedediah Leland', fi.id, at.id from film fi, attore at where fi.regista = 'Orson Welles' and fi.anno = 1941 and at.nome = 'Joseph' and at.cognome = 'Cotten';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Rick Blaine', fi.id, at.id from film fi, attore at where fi.regista = 'Michael Curtiz' and fi.anno = 1942 and at.nome = 'Humphrey' and at.cognome = 'Bogart';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Ilsa Lund', fi.id, at.id from film fi, attore at where fi.regista = 'Michael Curtiz' and fi.anno = 1942 and at.nome = 'Ingrid' and at.cognome = 'Bergman';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'L.B. Jefferies', fi.id, at.id from film fi, attore at where fi.regista = 'Alfred Hitchcock' and fi.anno = 1954 and at.nome = 'James' and at.cognome = 'Stewart';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Lisa Fremont', fi.id, at.id from film fi, attore at where fi.regista = 'Alfred Hitchcock' and fi.anno = 1954 and at.nome = 'Grace' and at.cognome = 'Kelly';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Norman Bates', fi.id, at.id from film fi, attore at where fi.regista = 'Alfred Hitchcock' and fi.anno = 1960 and at.nome = 'Anthony' and at.cognome = 'Perkins';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Marion Crane', fi.id, at.id from film fi, attore at where fi.regista = 'Alfred Hitchcock' and fi.anno = 1960 and at.nome = 'Janet' and at.cognome = 'Leigh';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Vito Corleone', fi.id, at.id from film fi, attore at where fi.regista = 'Francis Ford Coppola' and fi.anno = 1972 and at.nome = 'Marlon' and at.cognome = 'Brando';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Michael Corleone', fi.id, at.id from film fi, attore at where fi.regista = 'Francis Ford Coppola' and fi.anno = 1972 and at.nome = 'Al' and at.cognome = 'Pacino';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Sonny Corleone', fi.id, at.id from film fi, attore at where fi.regista = 'Francis Ford Coppola' and fi.anno = 1972 and at.nome = 'James' and at.cognome = 'Caan';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Travis Bickle', fi.id, at.id from film fi, attore at where fi.regista = 'Martin Scorsese' and fi.anno = 1976 and at.nome = 'Robert' and at.cognome = 'De Niro';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Iris', fi.id, at.id from film fi, attore at where fi.regista = 'Martin Scorsese' and fi.anno = 1976 and at.nome = 'Jodie' and at.cognome = 'Foster';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Clarice Starling', fi.id, at.id from film fi, attore at where fi.regista = 'Jonathan Demme' and fi.anno = 1991 and at.nome = 'Jodie' and at.cognome = 'Foster';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Hannibal Lecter', fi.id, at.id from film fi, attore at where fi.regista = 'Jonathan Demme' and fi.anno = 1991 and at.nome = 'Anthony' and at.cognome = 'Hopkins';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Vincent Vega', fi.id, at.id from film fi, attore at where fi.regista = 'Quentin Tarantino' and fi.anno = 1994 and at.nome = 'John' and at.cognome = 'Travolta';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Jules Winnfield', fi.id, at.id from film fi, attore at where fi.regista = 'Quentin Tarantino' and fi.anno = 1994 and at.nome = 'Samuel L.' and at.cognome = 'Jackson';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Mia Wallace', fi.id, at.id from film fi, attore at where fi.regista = 'Quentin Tarantino' and fi.anno = 1994 and at.nome = 'Uma' and at.cognome = 'Thurman';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Rick Deckard', fi.id, at.id from film fi, attore at where fi.regista = 'Ridley Scott' and fi.anno = 1982 and at.nome = 'Harrison' and at.cognome = 'Ford';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Roy Batty', fi.id, at.id from film fi, attore at where fi.regista = 'Ridley Scott' and fi.anno = 1982 and at.nome = 'Rutger' and at.cognome = 'Hauer';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Maria', fi.id, at.id from film fi, attore at where fi.regista = 'Fritz Lang' and fi.anno = 1927 and at.nome = 'Brigitte' and at.cognome = 'Helm';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Joh Fredersen', fi.id, at.id from film fi, attore at where fi.regista = 'Fritz Lang' and fi.anno = 1927 and at.nome = 'Alfred' and at.cognome = 'Abel';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Hans Beckert', fi.id, at.id from film fi, attore at where fi.regista = 'Fritz Lang' and fi.anno = 1931 and at.nome = 'Peter' and at.cognome = 'Lorre';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Damiel', fi.id, at.id from film fi, attore at where fi.regista = 'Wim Wenders' and fi.anno = 1987 and at.nome = 'Bruno' and at.cognome = 'Ganz';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Se stesso (Peter Falk)', fi.id, at.id from film fi, attore at where fi.regista = 'Wim Wenders' and fi.anno = 1987 and at.nome = 'Peter' and at.cognome = 'Falk';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Alma', fi.id, at.id from film fi, attore at where fi.regista = 'Ingmar Bergman' and fi.anno = 1966 and at.nome = 'Bibi' and at.cognome = 'Andersson';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Elisabet Vogler', fi.id, at.id from film fi, attore at where fi.regista = 'Ingmar Bergman' and fi.anno = 1966 and at.nome = 'Liv' and at.cognome = 'Ullmann';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Antonius Block', fi.id, at.id from film fi, attore at where fi.regista = 'Ingmar Bergman' and fi.anno = 1957 and at.nome = 'Max' and at.cognome = 'von Sydow';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), U&'J\00f6ns', fi.id, at.id from film fi, attore at where fi.regista = 'Ingmar Bergman' and fi.anno = 1957 and at.nome = 'Gunnar' and at.cognome = U&'Bj\00f6rnstrand';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Tajomaru', fi.id, at.id from film fi, attore at where fi.regista = 'Akira Kurosawa' and fi.anno = 1950 and at.nome = 'Toshiro' and at.cognome = 'Mifune';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Masako', fi.id, at.id from film fi, attore at where fi.regista = 'Akira Kurosawa' and fi.anno = 1950 and at.nome = 'Machiko' and at.cognome = U&'Ky\014d';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Kambei', fi.id, at.id from film fi, attore at where fi.regista = 'Akira Kurosawa' and fi.anno = 1954 and at.nome = 'Takashi' and at.cognome = 'Shimura';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Kikuchiyo', fi.id, at.id from film fi, attore at where fi.regista = 'Akira Kurosawa' and fi.anno = 1954 and at.nome = 'Toshiro' and at.cognome = 'Mifune';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Shukichi Hirayama', fi.id, at.id from film fi, attore at where fi.regista = 'Yasujiro Ozu' and fi.anno = 1953 and at.nome = U&'Chish\016b' and at.cognome = U&'Ry\016b';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Noriko', fi.id, at.id from film fi, attore at where fi.regista = 'Yasujiro Ozu' and fi.anno = 1953 and at.nome = 'Setsuko' and at.cognome = 'Hara';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Antoine Doinel', fi.id, at.id from film fi, attore at where fi.regista = 'Francois Truffaut' and fi.anno = 1959 and at.nome = 'Jean-Pierre' and at.cognome = U&'L\00e9aud';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Michel Poiccard', fi.id, at.id from film fi, attore at where fi.regista = 'Jean-Luc Godard' and fi.anno = 1960 and at.nome = 'Jean-Paul' and at.cognome = 'Belmondo';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Patricia Franchini', fi.id, at.id from film fi, attore at where fi.regista = 'Jean-Luc Godard' and fi.anno = 1960 and at.nome = 'Jean' and at.cognome = 'Seberg';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), U&'Am\00e9lie Poulain', fi.id, at.id from film fi, attore at where fi.regista = 'Jean-Pierre Jeunet' and fi.anno = 2001 and at.nome = 'Audrey' and at.cognome = 'Tautou';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Nino Quincampoix', fi.id, at.id from film fi, attore at where fi.regista = 'Jean-Pierre Jeunet' and fi.anno = 2001 and at.nome = 'Mathieu' and at.cognome = 'Kassovitz';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Kim Ki-taek', fi.id, at.id from film fi, attore at where fi.regista = 'Bong Joon-ho' and fi.anno = 2019 and at.nome = 'Kang-ho' and at.cognome = 'Song';
insert into interpretazione (id, personaggio, film_id, attore_id) select nextval('interpretazione_seq'), 'Kim Ki-woo', fi.id, at.id from film fi, attore at where fi.regista = 'Bong Joon-ho' and fi.anno = 2019 and at.nome = 'Woo-shik' and at.cognome = 'Choi';
