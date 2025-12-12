CREATE INDEX IF NOT EXISTS idx_biglietto_id_corsa ON biglietto(id_corsa);
CREATE INDEX IF NOT EXISTS idx_biglietto_cf ON biglietto(cf_passeggero);
CREATE INDEX IF NOT EXISTS idx_corsa_id_tratta ON corsa(id_tratta);
CREATE INDEX IF NOT EXISTS idx_stazione_id_regione ON stazione(id_regione);

CREATE INDEX IF NOT EXISTS idx_stazione_nome ON stazione(nome_stazione);
CREATE INDEX IF NOT EXISTS idx_passeggero_email ON passeggero(email);
CREATE INDEX IF NOT EXISTS idx_passeggero_num_cliente ON passeggero(num_cliente);

CREATE INDEX IF NOT EXISTS idx_stazione_regione_nome ON stazione(id_regione, nome_stazione);
