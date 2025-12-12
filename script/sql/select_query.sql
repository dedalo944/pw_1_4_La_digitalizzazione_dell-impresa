SELECT
  p.codice_fiscale,
  p.nominativo,
  COUNT(DISTINCT b.id_corsa) AS numero_corse_effettuate,
  SUM(b.prezzo) AS totale_speso
FROM passeggero p
JOIN biglietto b ON p.codice_fiscale = b.cf_passeggero
GROUP BY p.codice_fiscale, p.nominativo;

SELECT DISTINCT
  s.id,
  s.nome_stazione
FROM stazione s
JOIN tratta t
  ON t.id_stazione_partenza = s.id OR t.id_stazione_arrivo = s.id
JOIN corsa c
  ON c.id_tratta = t.id
WHERE c.stato = 'Regolare';

SELECT DISTINCT
  p.codice_fiscale,
  p.nominativo
FROM passeggero p
JOIN biglietto b ON p.codice_fiscale = b.cf_passeggero
JOIN corsa c ON b.id_corsa = c.id
WHERE c.id_tratta = 41;


SELECT
  aa.id,
  aa.cf_passeggero,
  p.nominativo,
  aa.data_fine
FROM abbonamento_attivo aa inner join passeggero p on aa.cf_passeggero = p.codice_fiscale 
WHERE aa.data_fine BETWEEN CURRENT_DATE AND (CURRENT_DATE + INTERVAL '7 days');

SELECT
    c.id AS id_corsa,
    s.nome_stazione,
    pc.n_punto ,
    pc.orario_arrivo,
    pc.orario_partenza
FROM corsa c
JOIN punto_corsa pc ON pc.id_corsa = c.id
JOIN stazione s ON s.id = pc.id_stazione
WHERE c.stato = 'Regolare' and id_corsa = 4
ORDER BY c.id, pc.n_punto;

SELECT 
    s.nome_stazione, 
    r.nome_regione,
    COUNT(c.id) AS numero_partenze_programmate
FROM stazione s
JOIN regione r ON s.id_regione = r.id
JOIN tratta t ON t.id_stazione_partenza = s.id
JOIN corsa c ON c.id_tratta = t.id
WHERE c.stato = 'Regolare'
GROUP BY s.nome_stazione, r.nome_regione;

SELECT c.id, SUM(t.distanza_km) AS totale_km_percorsi
FROM corsa c
JOIN tratta t ON c.id_tratta = t.id
WHERE c.stato = 'Regolare'
GROUP BY c.id;