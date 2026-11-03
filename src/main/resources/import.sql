
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
insert into festival (id, nome, anno, citta, data_inizio, data_fine, descrizione) values (nextval('festival_seq'), 'Troisi Festival', 2025, 'Roma', '2025-09-18', '2025-09-23', 'Omaggio artistico al cinema agrodolce di Massimo Troisi');
insert into festival (id, nome, anno, citta, data_inizio, data_fine, descrizione) values (nextval('festival_seq'), 'Torino Cinema Classico', 2024, 'Torino', '2024-11-05', '2024-11-10', 'Rassegna dei capolavori del cinema italiano del dopoguerra e del boom');
insert into festival (id, nome, anno, citta, data_inizio, data_fine, descrizione) values (nextval('festival_seq'), 'Festival dei Maestri del Cinema', 2026, 'Bologna', '2026-03-12', '2026-03-18', 'I grandi maestri della regia internazionale, dal muto agli anni Settanta');

-- Festival PRESENTI (in corso)
insert into festival (id, nome, anno, citta, data_inizio, data_fine, descrizione) values (nextval('festival_seq'), 'Cinema in Laguna', 2026, 'Venezia', '2026-10-29', '2026-11-05', 'Il grande cinema d''autore di tutto il mondo sulle rive della laguna');
insert into festival (id, nome, anno, citta, data_inizio, data_fine, descrizione) values (nextval('festival_seq'), 'Napoli Film Days', 2026, 'Napoli', '2026-11-01', '2026-11-08', 'Otto giorni di cinema italiano, tra Napoli, commedia e racconto civile');

-- Festival FUTURI
insert into festival (id, nome, anno, citta, data_inizio, data_fine, descrizione) values (nextval('festival_seq'), 'Torino Notte Nera', 2027, 'Torino', '2027-01-20', '2027-01-26', 'Una settimana di noir, thriller e suspense');
insert into festival (id, nome, anno, citta, data_inizio, data_fine, descrizione) values (nextval('festival_seq'), 'Fellini Cinema Award', 2027, 'Rimini', '2027-04-14', '2027-04-20', 'Opere che sfidano il realismo per esplorare il sogno');
insert into festival (id, nome, anno, citta, data_inizio, data_fine, descrizione) values (nextval('festival_seq'), 'Roma Classic Cinema', 2027, 'Roma', '2027-06-10', '2027-06-16', 'I classici che hanno fatto la storia del cinema, tra western, kolossal e commedia');

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