CREATE OR REPLACE VIEW vista_posti_disponibili AS
SELECT
    c.id AS id_corsa,
    m.codice_mezzo,
    m.capienza,
    COUNT(b.id) AS biglietti_venduti,
    (m.capienza - COUNT(b.id)) AS posti_disponibili
FROM corsa c
JOIN mezzo m ON m.id = c.id_mezzo
LEFT JOIN biglietto b ON b.id_corsa = c.id
GROUP BY c.id, m.codice_mezzo, m.capienza;