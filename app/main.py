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
    "How many units of products are on sale by product category in price equivalent. Show those that are more expensive than 5000"
    cur.execute(
         """SELECT category_name, sum(unit_price * units_in_stock)
            FROM products
            INNER JOIN categories ON products.category_id = categories.category_id
            WHERE discontinued  <> 1
            GROUP BY category_name
            HAVING sum(unit_price * units_in_stock) > 5000
            ORDER BY sum(unit_price * units_in_stock) desc
            LIMIT 5;"""
    )
    conn.commit()
    rows = cur.fetchall()
    for row in rows:
        print(*row)

else:
    print(">>>>> Fail to connect to DB! <<<<<<<")
# Close communications with database
cur.close()
conn.close()


