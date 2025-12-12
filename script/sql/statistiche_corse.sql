CREATE MATERIALIZED VIEW IF NOT EXISTS mv_statistiche_corse AS
SELECT 
    c.id,
    c.stato,
    c.data_partenza,
    c.data_arrivo,
    COUNT(b.id) as num_biglietti,
    SUM(b.prezzo) as ricavo_totale,
    AVG(b.prezzo) as prezzo_medio,
    t.distanza_km,
    sp.nome_stazione as stazione_partenza,
    sa.nome_stazione as stazione_arrivo
FROM corsa c
JOIN tratta t ON c.id_tratta = t.id
JOIN stazione sp ON t.id_stazione_partenza = sp.id
JOIN stazione sa ON t.id_stazione_arrivo = sa.id
LEFT JOIN biglietto b ON c.id = b.id_corsa
GROUP BY c.id, c.stato, c.data_partenza, c.data_arrivo, t.distanza_km, sp.nome_stazione, sa.nome_stazione;


CREATE UNIQUE INDEX IF NOT EXISTS idx_mv_statistiche_corse_id ON mv_statistiche_corse(id);

CREATE OR REPLACE FUNCTION refresh_statistiche_corse()
RETURNS void AS $$
BEGIN
    REFRESH MATERIALIZED VIEW CONCURRENTLY mv_statistiche_corse;
END;
$$ LANGUAGE plpgsql;