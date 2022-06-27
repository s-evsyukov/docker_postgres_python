# https://www.psycopg.org/docs/usage.html
import psycopg2

# Connect to existing database
conn = psycopg2.connect(
    database="northwind",
    user="postgres",
    password="postgres",
    host="db",
    port="5432"
)

# Open cursor to perform database operation
cur = conn.cursor()

# Query the database
if cur:

    cur.execute("SELECT * FROM orders LIMIT 5;")
    # cur.execute("SELECT * FROM students LIMIT 5;")
    conn.commit()
    rows = cur.fetchall()
    for row in rows:
        print(*row)

else:
    print(">>>>> Fail to connect to DB! <<<<<<<")
# Close communications with database
cur.close()
conn.close()


