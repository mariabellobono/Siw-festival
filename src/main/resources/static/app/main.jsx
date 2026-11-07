// PUNTO DI INGRESSO: sceglie la pagina in base all'indirizzo (#/...) e la disegna dentro <div id="root">.
// Gli indirizzi con # si chiamano "hash routing": il server non e' coinvolto, cambia solo la pagina React.

function usePercorso() {
  const [hash, setHash] = useState(window.location.hash || '#/');
  useEffect(() => {
    const aggiorna = () => setHash(window.location.hash || '#/');
    window.addEventListener('hashchange', aggiorna);
    return () => window.removeEventListener('hashchange', aggiorna);
  }, []);
  return hash.replace(/^#/, '');
}

function App() {
  const [utente, setUtente] = useState(null);   // null = non ancora caricato
  const percorso = usePercorso();

  // all'avvio si chiede al server chi e' collegato (e intanto arriva il cookie CSRF)
  useEffect(() => {
    api.get('/api/auth/me')
      .then(setUtente)
      .catch(() => setUtente({ authenticated: false, admin: false }));
  }, []);

  const p = percorso.split('/').filter(Boolean);   // '/film/3/modifica' -> ['film', '3', 'modifica']
  let pagina;
  if (p.length === 0) {
    pagina = <PaginaFilm utente={utente} />;
  } else if (p[0] === 'film-nuovo') {
    pagina = <FormFilm utente={utente} />;
  } else if (p[0] === 'film' && p[1] && p[2] === 'modifica') {
    pagina = <FormFilm key={p[1]} id={p[1]} utente={utente} />;
  } else if (p[0] === 'film' && p[1]) {
    pagina = <DettaglioFilm key={p[1]} id={p[1]} utente={utente} />;
  } else if (p[0] === 'festival' && p[1]) {
    pagina = <DettaglioFestival key={p[1]} id={p[1]} />;
  } else if (p[0] === 'festival') {
    pagina = <ListaFestival />;
  } else if (p[0] === 'proiezioni') {
    pagina = <PaginaProiezioni />;
  } else {
    pagina = <p>Pagina non trovata.</p>;
  }

  return (
    <div>
      <header>
        <nav>
          <a href="#/">Film</a>
          <a href="#/festival">Festival</a>
          <a href="#/proiezioni">Proiezioni</a>
          <a href="/">Sito principale</a>
        </nav>
        <LoginBox utente={utente} setUtente={setUtente} />
      </header>
      <main>{pagina}</main>
    </div>
  );
}

ReactDOM.createRoot(document.getElementById('root')).render(<App />);
