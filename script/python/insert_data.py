import csv
import psycopg2
from psycopg2.extras import execute_values
import os

DB_CONFIG = {
    'host': 'localhost',
    'port': 5432,
    'database': 'postgres',
    'user': 'postgres',
    'password': 'admin'
}

CSV_FILE = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), 
                        'utils', 'Stazioni italiane.csv')

REGIONI_MAPPING = {
    1: 'Lombardia',
    2: 'Liguria',
    3: 'Piemonte',
    4: 'Valle d\'Aosta',
    5: 'Lazio',
    6: 'Umbria',
    7: 'Molise',
    8: 'Emilia-Romagna',
    9: 'Trentino-Alto Adige',
    10: 'Friuli-Venezia Giulia',
    11: 'Marche',
    12: 'Veneto',
    13: 'Toscana',
    14: 'Sicilia',
    15: 'Basilicata',
    16: 'Puglia',
    17: 'Calabria',
    18: 'Campania',
    19: 'Abruzzo',
    20: 'Sardegna'
}

def connect_db():
    try:
        conn = psycopg2.connect(**DB_CONFIG)
        return conn
    except psycopg2.Error as e:
        print(f"Errore nella connessione al database: {e}")
        raise

def read_csv():
    stazioni = []
    try:
        with open(CSV_FILE, 'r', encoding='utf-8') as file:
            reader = csv.DictReader(file)
            for row in reader:
                region_num = int(row['region'])
                if 1 <= region_num <= 20:
                    stazioni.append({
                        'code': row['code'],
                        'region': region_num,
                        'long_name': row['long_name'],
                        'short_name': row['short_name'],
                        'latitude': float(row['latitude']),
                        'longitude': float(row['longitude'])
                    })
        return stazioni
    except FileNotFoundError:
        print(f"File non trovato: {CSV_FILE}")
        raise
    except Exception as e:
        print(f"Errore nella lettura del CSV: {e}")
        raise

def insert_regioni(conn, stazioni):
    cursor = conn.cursor()
    
    regioni = set(stazione['region'] for stazione in stazioni if 1 <= stazione['region'] <= 20)
    
    cursor.execute("SELECT id, nome_regione FROM regione")
    regioni_esistenti = {row[1]: row[0] for row in cursor.fetchall()}
    
    regione_to_id = {}
    
    for regione_num in sorted(regioni):
        nome_regione = REGIONI_MAPPING.get(regione_num, f"Regione {regione_num}")
        
        if nome_regione in regioni_esistenti:
            regione_to_id[regione_num] = regioni_esistenti[nome_regione]
        else:
            cursor.execute(
                "INSERT INTO regione (nome_regione) VALUES (%s) RETURNING id",
                (nome_regione,)
            )
            new_id = cursor.fetchone()[0]
            regione_to_id[regione_num] = new_id
    
    conn.commit()
    cursor.close()
    return regione_to_id

def insert_stazioni(conn, stazioni, regione_to_id):
    cursor = conn.cursor()
    dati_stazioni = []
    for stazione in stazioni:
        region_num = stazione['region']
        if 1 <= region_num <= 20 and region_num in regione_to_id:
            id_regione = regione_to_id[region_num]
            dati_stazioni.append((
                stazione['long_name'],
                id_regione
            ))
    
    execute_values(
        cursor,
        "INSERT INTO stazione (nome_stazione, id_regione) VALUES %s",
        dati_stazioni,
        template=None,
        page_size=100
    )
    conn.commit()
    print(f"Inserite {len(dati_stazioni)} stazioni nel database")
    cursor.close()

def main():    
    stazioni = read_csv()
    conn = connect_db()
    
    try:
        regione_to_id = insert_regioni(conn, stazioni)
        insert_stazioni(conn, stazioni, regione_to_id)
        
    except Exception as e:
        print(f"Errore durante l'inserimento: {e}")
        conn.rollback()
        raise
    finally:
        conn.close()

if __name__ == "__main__":
    main()

