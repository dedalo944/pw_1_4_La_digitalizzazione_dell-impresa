CREATE OR REPLACE FUNCTION aggiorna_prezzo_biglietto_corsa()
RETURNS TRIGGER AS $$
DECLARE
    orario_previsto_arrivo TIMESTAMP;
    distanza_tratta DOUBLE PRECISION;
BEGIN
    IF NEW.stato = 'Annullato' THEN
        UPDATE biglietto
        SET prezzo = 0.00
        WHERE id_corsa = NEW.id;
        RETURN NEW;
    END IF;

    IF NEW.stato = 'In ritardo' THEN
        SELECT distanza_km INTO distanza_tratta
        FROM tratta
        WHERE id = NEW.id_tratta;

        IF distanza_tratta IS NOT NULL THEN
            orario_previsto_arrivo := NEW.data_partenza + (distanza_tratta / 100.0 * INTERVAL '1 hour');
            IF NEW.data_arrivo > (orario_previsto_arrivo + INTERVAL '2 hours') THEN
                UPDATE biglietto
                SET prezzo = 0.00
                WHERE id_corsa = NEW.id;
            END IF;
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_aggiorna_prezzo_biglietto_corsa
    AFTER UPDATE ON corsa
    FOR EACH ROW
    WHEN (NEW.stato = 'Annullato' OR NEW.stato = 'In ritardo')
    EXECUTE FUNCTION aggiorna_prezzo_biglietto_corsa();

