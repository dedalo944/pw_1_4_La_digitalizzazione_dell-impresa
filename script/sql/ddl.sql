
CREATE TABLE regione (
    id SERIAL PRIMARY KEY,
    nome_regione VARCHAR NOT NULL UNIQUE
);

CREATE TABLE stazione (
    id SERIAL PRIMARY KEY,
    nome_stazione VARCHAR NOT NULL,
    id_regione INTEGER REFERENCES regione(id)
);

CREATE TABLE passeggero (
    codice_fiscale VARCHAR PRIMARY KEY,
    num_cliente VARCHAR NOT NULL UNIQUE,
    email VARCHAR NOT NULL UNIQUE,
    password VARCHAR NOT NULL,
    nominativo VARCHAR NOT NULL,
    created_at TIMESTAMP DEFAULT now(),
    CONSTRAINT check_email_format CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    CONSTRAINT check_codice_fiscale_length CHECK (LENGTH(codice_fiscale) = 16)
);

CREATE TABLE abbonamento (
    id SERIAL PRIMARY KEY,
    nome_abbonamento VARCHAR NOT NULL,
    perc_offerta INTEGER NOT NULL,
    CONSTRAINT check_perc_offerta CHECK (perc_offerta >= 0 AND perc_offerta <= 100)
);

CREATE TABLE abbonamento_attivo (
    id SERIAL PRIMARY KEY,
    cf_passeggero VARCHAR REFERENCES passeggero(codice_fiscale),
    id_abbonamento INTEGER REFERENCES abbonamento(id),
    data_inizio DATE NOT NULL DEFAULT now(),
    data_fine DATE,
    CONSTRAINT unique_abbonamento_attivo UNIQUE (cf_passeggero, id_abbonamento),
    CHECK (data_fine IS NULL OR data_fine >= data_inizio)
);

CREATE TABLE mezzo (
    id SERIAL PRIMARY KEY,
    codice_mezzo VARCHAR NOT NULL UNIQUE,
    capienza INTEGER NOT NULL CHECK (capienza > 0)
);

CREATE TABLE tratta (
    id SERIAL PRIMARY KEY,
    id_stazione_partenza INTEGER NOT NULL REFERENCES stazione(id),
    id_stazione_arrivo INTEGER NOT NULL REFERENCES stazione(id),
    id_mezzo INTEGER NOT NULL REFERENCES mezzo(id),
    distanza_km DOUBLE PRECISION,
    prezzo_fisso NUMERIC(8,2) NOT NULL DEFAULT 1.00,
    CONSTRAINT check_prezzo_fisso_minimo CHECK (prezzo_fisso > 0),
    CONSTRAINT check_tratta_stazioni_diverse CHECK (id_stazione_partenza != id_stazione_arrivo)
);

CREATE TABLE corsa (
    id SERIAL PRIMARY KEY,
    id_tratta INTEGER NOT NULL REFERENCES tratta(id),
    data_partenza TIMESTAMP NOT NULL,
    data_arrivo TIMESTAMP NOT NULL,
    stato VARCHAR NOT NULL DEFAULT 'Regolare',
    info VARCHAR DEFAULT NULL,
    CONSTRAINT check_corsa_date CHECK (data_arrivo >= data_partenza),
    CONSTRAINT check_posti_disponibili CHECK (posti_disponibili >= 0),
    CONSTRAINT stato_valido CHECK (stato IN ('Regolare', 'Completato', 'In ritardo', 'Annullato')),
    CONSTRAINT unique_mezzo_nel_tempo UNIQUE (id_mezzo, data_partenza);
);

CREATE TABLE biglietto (
    id SERIAL PRIMARY KEY,
    cf_passeggero VARCHAR REFERENCES passeggero(codice_fiscale),
    id_corsa INTEGER REFERENCES corsa(id),
    id_abbonamento_attivo INTEGER REFERENCES abbonamento_attivo(id),
    prezzo NUMERIC(8,2) NOT NULL DEFAULT 0.00,
    data_acquisto TIMESTAMP DEFAULT now(),
    CONSTRAINT check_prezzo_positivo CHECK (prezzo >= 0)
);

CREATE TABLE punto_corsa (
    id serial PRIMARY KEY,
    id_corsa integer NOT NULL REFERENCES corsa(id) ON DELETE CASCADE,
    id_stazione integer NOT NULL REFERENCES stazione(id),
    n_punto integer NOT NULL DEFAULT 0,
    tipologia varchar NOT NULL DEFAULT 'Fermata',
    orario_arrivo timestamp,
    orario_partenza timestamp,
    CONSTRAINT punto_corsa_id_corsa_n_punto_key UNIQUE (id_corsa, n_punto),
    CONSTRAINT check_punto_tipologia CHECK (
        tipologia IN ('Partenza', 'Fermata', 'Cambio', 'Arrivo')
    )
);