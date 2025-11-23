
CREATE TABLE regione (
    id SERIAL PRIMARY KEY,
    nome_regione VARCHAR NOT NULL UNIQUE
);

CREATE TABLE stazione (
    id SERIAL PRIMARY KEY,
    nome_stazione VARCHAR NOT NULL,
    id_regione INTEGER REFERENCES regione(id)
);

CREATE TABLE passegero (
    codice_fiscale VARCHAR PRIMARY KEY,
    num_cliente VARCHAR NOT NULL UNIQUE,
    email VARCHAR NOT NULL UNIQUE,
    password VARCHAR NOT NULL,
    nominativo VARCHAR NOT NULL,
    created_at TIMESTAMP DEFAULT now()
);

CREATE TABLE abbonamento (
    id SERIAL PRIMARY KEY,
    nome_abbonamento VARCHAR NOT NULL,
    perc_offerta INTEGER NOT NULL
);

CREATE TABLE abbonamento_attivo (
    id SERIAL PRIMARY KEY,
    cf_passeggero VARCHAR REFERENCES passegero(codice_fiscale),
    id_abbonamento INTEGER REFERENCES abbonamento(id),
    data_inizio DATE NOT NULL DEFAULT now(),
    data_fine DATE,
    CONSTRAINT unique_abbonamento_attivo UNIQUE (cf_passeggero, id_abbonamento),
    CHECK (data_fine IS NULL OR data_fine >= data_inizio)
);

CREATE TABLE tratta (
    id SERIAL PRIMARY KEY,
    id_stazione_partenza INTEGER NOT NULL REFERENCES stazione(id),
    id_stazione_arrivo INTEGER NOT NULL REFERENCES stazione(id),
    distanza_km DOUBLE PRECISION
);

CREATE TABLE corsa (
    id SERIAL PRIMARY KEY,
    id_tratta INTEGER NOT NULL REFERENCES tratta(id),
    data_partenza TIMESTAMP NOT NULL,
    data_arrivo TIMESTAMP NOT NULL,
    posti_disponibili INTEGER,
    stato VARCHAR NOT NULL DEFAULT 'Regolare',
    CONSTRAINT stato_valido CHECK (stato IN ('Regolare', 'Completato', 'In ritardo', 'Annullato'))
);

CREATE TABLE biglietto (
    id SERIAL PRIMARY KEY,
    cf_passeggero VARCHAR REFERENCES passegero(codice_fiscale),
    id_corsa INTEGER REFERENCES corsa(id),
    id_abbonamento_attivo INTEGER REFERENCES abbonamento_attivo(id),
    prezzo NUMERIC(8,2) NOT NULL DEFAULT 0.00,
    data_acquisto TIMESTAMP DEFAULT now()
);