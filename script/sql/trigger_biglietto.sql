CREATE OR REPLACE FUNCTION calcola_prezzo_scontato()
RETURNS TRIGGER AS $$
DECLARE
    sconto_percentuale INTEGER DEFAULT 0;
    prezzo_base NUMERIC(8,2);
BEGIN
    SELECT t.prezzo_fisso INTO prezzo_base
    FROM corsa c
    JOIN tratta t ON c.id_tratta = t.id
    WHERE c.id = NEW.id_corsa;

    IF prezzo_base IS NULL THEN
        prezzo_base := COALESCE(NEW.prezzo, 0);
    END IF;

    IF NEW.id_abbonamento_attivo IS NOT NULL THEN
        SELECT a.perc_offerta INTO sconto_percentuale
        FROM abbonamento_attivo aa
        INNER JOIN abbonamento a ON aa.id_abbonamento = a.id
        WHERE aa.id = NEW.id_abbonamento_attivo
          AND (aa.data_fine IS NULL OR aa.data_fine >= CURRENT_DATE);
        
        IF sconto_percentuale IS NULL THEN
            sconto_percentuale := 0;
        END IF;
    END IF;

    NEW.prezzo := prezzo_base * (1 - sconto_percentuale::NUMERIC / 100);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_calcola_prezzo_biglietto
    BEFORE INSERT ON biglietto
    FOR EACH ROW
    EXECUTE FUNCTION calcola_prezzo_scontato();

