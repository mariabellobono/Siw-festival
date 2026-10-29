-- FESTIVAL
insert into festival (id, nome, anno, citta, data_inizio, data_fine, descrizione) values (nextval('festival_seq'), 'Troisi Festival', 2025, 'Roma', '2025-09-18', '2025-09-23', 'Omaggio artistico al cinema agrodolce di Massimo Troisi');
insert into festival (id, nome, anno, citta, data_inizio, data_fine, descrizione) values (nextval('festival_seq'), 'Fellini Cinema Award', 2027, 'Rimini', '2027-04-14', '2027-04-20', 'Opere che sfidano il realismo per esplorare il sogno');

-- FILM
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'La malinconia dei giorni felici', 2025, 104, 'Commedia drammatica', 'Italia', 'Daniele Luchetti');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Ultimo tramonto sul Tevere', 2025, 98, 'Commedia sentimentale', 'Italia', 'Francesca Archibugi');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Il cielo sopra Testaccio', 2025, 92, 'Commedia poetica', 'Italia', 'Gianni Di Gregorio');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'La parata delle ombre', 2026, 118, 'Drammatico / Onirico', 'Italia', 'Matteo Garrone');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Il circo della memoria', 2026, 106, 'Drammatico / Fantastico', 'Italia', 'Alice Rohrwacher');
insert into film (id, titolo, anno, durata, genere, paese_produzione, regista) values (nextval('film_seq'), 'Lista dei desideri', 2026, 125, 'Drammatico / Grottesco', 'Italia', 'Paolo Sorrentino');

-- ASSOCIAZIONE FILM-FESTIVAL
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Troisi Festival' and film.titolo = 'La malinconia dei giorni felici';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Troisi Festival' and film.titolo = 'Ultimo tramonto sul Tevere';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Troisi Festival' and film.titolo = 'Il cielo sopra Testaccio';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Fellini Cinema Award' and film.titolo = 'La parata delle ombre';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Fellini Cinema Award' and film.titolo = 'Il circo della memoria';
insert into film_festival (festival_id, films_id) select festival.id, film.id from festival, film where festival.nome = 'Fellini Cinema Award' and film.titolo = 'Lista dei desideri';
