
import os
import mysql.connector

DB_HOST = os.environ.get("DB_HOST","localhost")
DB_USER = os.environ.get("DB_USER","root")
DB_PASS = os.environ.get("DB_PASS","")
DB_NAME = os.environ.get("DB_NAME","db_dinkominfostasandi_dummy")

SCHEMA_FILE = os.path.join(os.path.dirname(__file__), "..", "sql", "schema_fix.sql")

def run():
    conn = mysql.connector.connect(host=DB_HOST, user=DB_USER, password=DB_PASS, database=DB_NAME)
    cur = conn.cursor()
    with open(SCHEMA_FILE, "r", encoding="utf-8") as f:
        sql = f.read()
    for stmt in [s.strip() for s in sql.split(";") if s.strip()]:
        cur.execute(stmt)
    conn.commit()
    cur.close()
    conn.close()
    print("Schema applied successfully.")

if __name__ == "__main__":
    run()
