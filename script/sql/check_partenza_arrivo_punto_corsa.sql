CREATE OR REPLACE FUNCTION check_partenza_arrivo()
RETURNS trigger AS $$
BEGIN
    IF NEW.tipologia = 'Partenza' THEN
        IF EXISTS (SELECT 1 FROM punto_corsa WHERE id_corsa = NEW.id_corsa AND tipologia = 'Partenza' AND id <> NEW.id) THEN
            RAISE EXCEPTION 'Esiste già un punto di partenza per questa corsa.';
        END IF;
    END IF;
    IF NEW.tipologia = 'Arrivo' THEN
        IF EXISTS (SELECT 1 FROM punto_corsa WHERE id_corsa = NEW.id_corsa AND tipologia = 'Arrivo' AND id <> NEW.id) THEN
            RAISE EXCEPTION 'Esiste già un punto di arrivo per questa corsa.';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_partenza_arrivo
BEFORE INSERT OR UPDATE ON punto_corsa
FOR EACH ROW EXECUTE PROCEDURE check_partenza_arrivo();