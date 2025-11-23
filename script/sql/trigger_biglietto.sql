CREATE OR REPLACE FUNCTION calcola_prezzo_scontato()
RETURNS TRIGGER AS $$
DECLARE
    sconto_percentuale INTEGER;
BEGIN
    IF NEW.id_abbonamento_attivo IS NOT NULL THEN
        SELECT a.perc_offerta INTO sconto_percentuale
        FROM abbonamento_attivo aa
        INNER JOIN abbonamento a ON aa.id_abbonamento = a.id
        WHERE aa.id = NEW.id_abbonamento_attivo
          AND (aa.data_fine IS NULL OR aa.data_fine >= CURRENT_DATE);
        
        IF sconto_percentuale IS NOT NULL THEN
            NEW.prezzo := NEW.prezzo * (1 - sconto_percentuale::NUMERIC / 100);
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_calcola_prezzo_biglietto
    BEFORE INSERT ON biglietto
    FOR EACH ROW
    EXECUTE FUNCTION calcola_prezzo_scontato();

