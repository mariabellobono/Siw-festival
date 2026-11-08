// COMPONENTI REACT. Un componente e' una funzione che restituisce un pezzo di pagina (JSX = HTML dentro JavaScript).
// useState = una variabile che, quando cambia, ridisegna il componente.
// useEffect = codice che parte quando il componente compare o quando cambia qualcosa (qui: le chiamate all'API).
const { useState, useEffect } = React;

// cambia pagina: il percorso sta dopo il # dell'indirizzo (es. #/film/3)
function vaiA(percorso) {
  window.location.hash = '#' + percorso;
}

function Errore({ messaggio }) {
  return messaggio ? <div className="errore">{messaggio}</div> : null;
}

function ErroreCampo({ campi, nome }) {
  return campi && campi[nome] ? <span className="campo-errore">{campi[nome]}</span> : null;
}

function Campo({ etichetta, nome, tipo, dati, cambia, campi }) {
  return (
    <label>
      {etichetta}
      <input name={nome} type={tipo || 'text'} value={dati[nome]} onChange={cambia} />
      <ErroreCampo campi={campi} nome={nome} />
    </label>
  );
}

// ---------- LOGIN ----------
function LoginBox({ utente, setUtente }) {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [errore, setErrore] = useState(null);

  function accedi(e) {
    e.preventDefault();
    api.post('/api/auth/login', { username: username, password: password })
      .then((u) => {
        setUtente(u);
        setPassword('');
        setErrore(null);
      })
      .catch((err) => setErrore(err.message));
  }

  function esci() {
    api.post('/api/auth/logout')
      .then(() => setUtente({ authenticated: false, admin: false }))
      .catch((err) => setErrore(err.message));
  }

  if (utente && utente.authenticated) {
    return (
      <div>
        Ciao <b>{utente.nome || utente.username}</b>{utente.admin ? ' (admin)' : ''}{' '}
        <button className="secondario" onClick={esci}>Esci</button>
      </div>
    );
  }
  return (
    <form className="riga" onSubmit={accedi}>
      <input placeholder="Username" value={username} onChange={(e) => setUsername(e.target.value)} />
      <input type="password" placeholder="Password" value={password} onChange={(e) => setPassword(e.target.value)} />
      <button type="submit">Accedi</button>
      <a href="/register" style={{ color: '#fff' }}>Registrati</a>
      {errore && <span style={{ color: '#ffb4ab' }}>{errore}</span>}
    </form>
  );
}

// ---------- ELENCO E RICERCA FILM ----------
function PaginaFilm({ utente }) {
  const vuoti = { titolo: '', genere: '', regista: '' };
  const [filtri, setFiltri] = useState(vuoti);         // cio' che sta scritto nei campi
  const [applicati, setApplicati] = useState(vuoti);   // i filtri usati davvero per la ricerca
  const [pagina, setPagina] = useState(0);
  const [risultato, setRisultato] = useState(null);
  const [generi, setGeneri] = useState([]);
  const [errore, setErrore] = useState(null);

  useEffect(() => {
    api.get('/api/films/generi').then(setGeneri).catch(() => {});
  }, []);

  // ogni volta che cambiano i filtri o la pagina si richiama l'API
  useEffect(() => {
    const parametri = new URLSearchParams({
      titolo: applicati.titolo, genere: applicati.genere, regista: applicati.regista, page: pagina, size: 8,
    });
    api.get('/api/films?' + parametri.toString())
      .then((r) => { setRisultato(r); setErrore(null); })
      .catch((err) => setErrore(err.message));
  }, [applicati, pagina]);

  function cambia(e) {
    setFiltri({ ...filtri, [e.target.name]: e.target.value });
  }

  function cerca(e) {
    e.preventDefault();
    setPagina(0);
    setApplicati(filtri);
  }

  return (
    <div>
      <h1>Film</h1>
      <form className="riga" onSubmit={cerca}>
        <label>Titolo<input name="titolo" value={filtri.titolo} onChange={cambia} /></label>
        <label>Regista<input name="regista" value={filtri.regista} onChange={cambia} /></label>
        <label>Genere
          <select name="genere" value={filtri.genere} onChange={cambia}>
            <option value="">Tutti</option>
            {generi.map((g) => <option key={g} value={g}>{g}</option>)}
          </select>
        </label>
        <button type="submit">Cerca</button>
        {utente && utente.admin && <button type="button" onClick={() => vaiA('/film-nuovo')}>Nuovo film</button>}
      </form>
      <Errore messaggio={errore} />
      {!risultato && !errore && <p>Caricamento...</p>}
      {risultato && risultato.contenuto.length === 0 && <p>Nessun film trovato.</p>}
      {risultato && risultato.contenuto.map((f) => (
        <div className="card" key={f.id}>
          <a href={'#/film/' + f.id}><b>{f.titolo}</b> ({f.anno})</a>
          <div className="piccolo">{f.regista} &middot; {f.genere} &middot; {f.durata} min</div>
        </div>
      ))}
      {risultato && risultato.totalePagine > 1 && (
        <div className="paginazione">
          <button disabled={risultato.pagina === 0} onClick={() => setPagina(pagina - 1)}>Precedente</button>
          <span>Pagina {risultato.pagina + 1} di {risultato.totalePagine} ({risultato.totaleElementi} film)</span>
          <button disabled={risultato.pagina + 1 >= risultato.totalePagine} onClick={() => setPagina(pagina + 1)}>Successiva</button>
        </div>
      )}
    </div>
  );
}

// ---------- DETTAGLIO FILM + RECENSIONI ----------
function DettaglioFilm({ id, utente }) {
  const [film, setFilm] = useState(null);
  const [recensioni, setRecensioni] = useState([]);
  const [errore, setErrore] = useState(null);
  const [inModifica, setInModifica] = useState(false);

  function carica() {
    api.get('/api/films/' + id).then(setFilm).catch((e) => setErrore(e.message));
    api.get('/api/films/' + id + '/reviews').then(setRecensioni).catch((e) => setErrore(e.message));
  }

  useEffect(() => {
    carica();
  }, [id]);

  const collegato = utente && utente.authenticated;
  const mia = collegato ? recensioni.find((r) => r.utenteId === utente.utenteId) : null;

  function eliminaFilm() {
    if (!window.confirm('Eliminare questo film? Verranno eliminate anche le sue relative proiezioni e recensioni')) return;
    api.del('/api/films/' + id).then(() => vaiA('/')).catch((e) => setErrore(e.message));
  }

  function eliminaRecensione(idRecensione) {
    if (!window.confirm('Eliminare la tua recensione?')) return;
    api.del('/api/reviews/' + idRecensione)
      .then(() => { setInModifica(false); setErrore(null); carica(); })
      .catch((e) => setErrore(e.message));
  }

  if (!film) {
    return errore ? <Errore messaggio={errore} /> : <p>Caricamento...</p>;
  }

  return (
    <div>
      <p><a href="#/">&larr; Tutti i film</a></p>
      <Errore messaggio={errore} />
      <div className="card">
        <h1>{film.titolo} <span className="piccolo">({film.anno})</span></h1>
        <p>Regia: <b>{film.regista}</b> &middot; {film.genere} &middot; {film.durata} min &middot; {film.paeseProduzione}</p>
        <p>
          {film.mediaVoti !== null ? <span className="voto"><Stelle voto={Math.round(film.mediaVoti)} /> {film.mediaVoti}/5</span> : 'Nessun voto'}{' '}
          <span className="piccolo">({film.numeroRecensioni} recensioni)</span>
        </p>
        <p>
          {film.festival.map((f) => (
            <a key={f.id} className="badge" href={'#/festival/' + f.id}>{f.nome} {f.anno}</a>
          ))}
        </p>
        {utente && utente.admin && (
          <div className="riga">
            <button onClick={() => vaiA('/film/' + id + '/modifica')}>Modifica film</button>
            <button className="pericolo" onClick={eliminaFilm}>Elimina film</button>
          </div>
        )}
      </div>

      <h2>Recensioni</h2>
      {recensioni.length === 0 && <p>Ancora nessuna recensione.</p>}
      {recensioni.map((r) => (
        <div className="card" key={r.id}>
          <span className="voto"><Stelle voto={r.voto} /> {r.voto}/5</span> &middot; <b>{r.autore}</b> <span className="piccolo">{r.data}</span>
          <p>{r.testo}</p>
          {mia && mia.id === r.id && !inModifica && (
            <div className="riga">
              <button onClick={() => setInModifica(true)}>Modifica</button>
              <button className="pericolo" onClick={() => eliminaRecensione(r.id)}>Elimina</button>
            </div>
          )}
        </div>
      ))}

      {collegato && (!mia || inModifica) && (
        <FormRecensione
          filmId={id}
          esistente={inModifica ? mia : null}
          onFatto={() => { setInModifica(false); setErrore(null); carica(); }}
          onAnnulla={() => setInModifica(false)}
        />
      )}
      {!collegato && <p className="piccolo">Accedi per scrivere una recensione.</p>}
    </div>
  );
}

function FormRecensione({ filmId, esistente, onFatto, onAnnulla }) {
  const [voto, setVoto] = useState(esistente ? esistente.voto : 5);
  const [testo, setTesto] = useState(esistente ? esistente.testo : '');
  const [errore, setErrore] = useState(null);
  const [campi, setCampi] = useState({});

  function invia(e) {
    e.preventDefault();
    const corpo = { voto: Number(voto), testo: testo };
    const richiesta = esistente
      ? api.put('/api/reviews/' + esistente.id, corpo)                 // modifica
      : api.post('/api/films/' + filmId + '/reviews', corpo);          // nuova
    richiesta.then(() => onFatto()).catch((err) => { setErrore(err.message); setCampi(err.campi); });
  }

  return (
    <form className="card" onSubmit={invia}>
      <h2>{esistente ? 'Modifica la tua recensione' : 'Scrivi una recensione'}</h2>
      <Errore messaggio={errore} />
      <label>Voto
        <select value={voto} onChange={(e) => setVoto(e.target.value)}>
          {[1, 2, 3, 4, 5].map((v) => <option key={v} value={v}>{v}</option>)}
        </select>
        <ErroreCampo campi={campi} nome="voto" />
      </label>
      <label>Testo
        <textarea value={testo} onChange={(e) => setTesto(e.target.value)} />
        <ErroreCampo campi={campi} nome="testo" />
      </label>
      <div className="riga">
        <button type="submit">Salva</button>
        {esistente && <button type="button" className="secondario" onClick={onAnnulla}>Annulla</button>}
      </div>
    </form>
  );
}

// ---------- FORM FILM (solo admin): inserimento e modifica ----------
function FormFilm({ id, utente }) {
  const [dati, setDati] = useState({ titolo: '', anno: '', durata: '', genere: '', paeseProduzione: '', regista: '' });
  const [errore, setErrore] = useState(null);
  const [campi, setCampi] = useState({});

  useEffect(() => {
    if (id) {
      api.get('/api/films/' + id)
        .then((f) => setDati({ titolo: f.titolo, anno: f.anno, durata: f.durata, genere: f.genere,
          paeseProduzione: f.paeseProduzione, regista: f.regista }))
        .catch((e) => setErrore(e.message));
    }
  }, [id]);

  if (!utente) return <p>Caricamento...</p>;
  if (!utente.admin) {
    return <div className="errore">Questa pagina e' riservata all'amministratore: accedi come admin.</div>;
  }

  function cambia(e) {
    setDati({ ...dati, [e.target.name]: e.target.value });
  }

  function invia(e) {
    e.preventDefault();
    const corpo = {
      ...dati,
      anno: dati.anno === '' ? null : Number(dati.anno),
      durata: dati.durata === '' ? null : Number(dati.durata),
    };
    const richiesta = id ? api.put('/api/films/' + id, corpo) : api.post('/api/films', corpo);
    richiesta.then((f) => vaiA('/film/' + f.id)).catch((err) => { setErrore(err.message); setCampi(err.campi); });
  }

  return (
    <form className="card" onSubmit={invia}>
      <h1>{id ? 'Modifica film' : 'Nuovo film'}</h1>
      <Errore messaggio={errore} />
      <div className="riga">
        <Campo etichetta="Titolo" nome="titolo" dati={dati} cambia={cambia} campi={campi} />
        <Campo etichetta="Anno" nome="anno" tipo="number" dati={dati} cambia={cambia} campi={campi} />
        <Campo etichetta="Durata (minuti)" nome="durata" tipo="number" dati={dati} cambia={cambia} campi={campi} />
      </div>
      <div className="riga">
        <Campo etichetta="Genere" nome="genere" dati={dati} cambia={cambia} campi={campi} />
        <Campo etichetta="Paese di produzione" nome="paeseProduzione" dati={dati} cambia={cambia} campi={campi} />
        <Campo etichetta="Regista" nome="regista" dati={dati} cambia={cambia} campi={campi} />
      </div>
      <div className="riga">
        <button type="submit">Salva</button>
        <button type="button" className="secondario" onClick={() => vaiA(id ? '/film/' + id : '/')}>Annulla</button>
      </div>
    </form>
  );
}

// ---------- FESTIVAL ----------
// stelle del voto (1-5): piene = voto, vuote = il resto
function Stelle({ voto }) {
  const v = Math.max(0, Math.min(5, voto));
  return <span className="stelle">{'\u2605'.repeat(v) + '\u2606'.repeat(5 - v)}</span>;
}

function ListaFestival() {
  const [festival, setFestival] = useState(null);
  const [errore, setErrore] = useState(null);

  useEffect(() => {
    api.get('/api/festivals').then(setFestival).catch((e) => setErrore(e.message));
  }, []);

  return (
    <div>
      <h1>Festival</h1>
      <Errore messaggio={errore} />
      {!festival && !errore && <p>Caricamento...</p>}
      {festival && festival.map((f) => (
        <div className="card" key={f.id}>
          <img className="simbolo" src={f.immagine} alt="" />
          <a href={'#/festival/' + f.id}><b>{f.nome}</b> ({f.anno})</a>
          <div className="piccolo">{f.citta} &middot; dal {f.dataInizio} al {f.dataFine}</div>
        </div>
      ))}
    </div>
  );
}

function DettaglioFestival({ id }) {
  const [festival, setFestival] = useState(null);
  const [film, setFilm] = useState([]);
  const [proiezioni, setProiezioni] = useState([]);
  const [errore, setErrore] = useState(null);

  useEffect(() => {
    api.get('/api/festivals/' + id).then(setFestival).catch((e) => setErrore(e.message));
    api.get('/api/festivals/' + id + '/movies').then(setFilm).catch(() => {});
    api.get('/api/festivals/' + id + '/screenings').then(setProiezioni).catch(() => {});
  }, [id]);

  if (!festival) {
    return errore ? <Errore messaggio={errore} /> : <p>Caricamento...</p>;
  }
  return (
    <div>
      <p><a href="#/festival">&larr; Tutti i festival</a></p>
      <div className="card">
        <img className="simbolo-grande" src={festival.immagine} alt="" />
        <h1>{festival.nome} <span className="piccolo">({festival.anno})</span></h1>
        <p>{festival.citta} &middot; dal {festival.dataInizio} al {festival.dataFine}</p>
        <p>{festival.descrizione}</p>
      </div>
      <h2>Film in concorso</h2>
      {film.length === 0 && <p>Nessun film.</p>}
      {film.map((f) => (
        <div className="card" key={f.id}>
          <a href={'#/film/' + f.id}><b>{f.titolo}</b> ({f.anno})</a>
          <div className="piccolo">{f.regista} &middot; {f.genere}</div>
        </div>
      ))}
      <h2>Programma</h2>
      <TabellaProiezioni proiezioni={proiezioni} />
    </div>
  );
}

// ---------- PROIEZIONI ----------
function TabellaProiezioni({ proiezioni }) {
  if (proiezioni.length === 0) return <p>Nessuna proiezione.</p>;
  return (
    <table>
      <thead>
        <tr><th>Data</th><th>Ora</th><th>Film</th><th>Sala</th><th>Festival</th><th>Stato</th></tr>
      </thead>
      <tbody>
        {proiezioni.map((p) => (
          <tr key={p.id}>
            <td>{p.data}</td>
            <td>{p.ora}</td>
            <td><a href={'#/film/' + p.filmId}>{p.filmTitolo}</a></td>
            <td>{p.salaNome}</td>
            <td><a href={'#/festival/' + p.festivalId}>{p.festivalNome}</a></td>
            <td><span className={'stato stato-' + p.stato}>{p.stato}</span></td>
          </tr>
        ))}
      </tbody>
    </table>
  );
}

function PaginaProiezioni() {
  const [data, setData] = useState('');
  const [proiezioni, setProiezioni] = useState([]);
  const [errore, setErrore] = useState(null);

  useEffect(() => {
    const indirizzo = data ? '/api/screenings?data=' + data : '/api/screenings';
    api.get(indirizzo).then((r) => { setProiezioni(r); setErrore(null); }).catch((e) => setErrore(e.message));
  }, [data]);

  return (
    <div>
      <h1>Proiezioni</h1>
      <div className="riga">
        <label>Filtra per data<input type="date" value={data} onChange={(e) => setData(e.target.value)} /></label>
        {data && <button className="secondario" onClick={() => setData('')}>Tutte le date</button>}
      </div>
      <Errore messaggio={errore} />
      <TabellaProiezioni proiezioni={proiezioni} />
    </div>
  );
}
