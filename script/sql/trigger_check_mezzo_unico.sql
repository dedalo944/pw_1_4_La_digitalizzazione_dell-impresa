CREATE OR REPLACE FUNCTION check_mezzo_unico_per_intervallo()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.id_mezzo IS NOT NULL THEN
        IF EXISTS (
            SELECT 1 
            FROM corsa
            WHERE id_mezzo = NEW.id_mezzo
              AND id <> NEW.id
              AND (NEW.data_partenza, NEW.data_arrivo) OVERLAPS (data_partenza, data_arrivo)
        ) THEN
            RAISE EXCEPTION 'Il mezzo è già su un''altra tratta';
        END IF;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_mezzo_unico
    BEFORE INSERT OR UPDATE ON corsa
    FOR EACH ROW
    EXECUTE FUNCTION check_mezzo_unico_per_intervallo();
