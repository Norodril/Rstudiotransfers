# 132 Lecture 1 Code
#install.packages: "DBI", "RSQLite", "dplyr", "dbplyr", "tibble", "ggplot2"))
library(DBI)
library(RSQLite)
library(dplyr)
library(dbplyr)
library(tibble)
library(ggplot2)




library(DBI)
library(RSQLite)

# Connect to the same database used by HW1
PSTAT132db <- dbConnect(
  SQLite(),
  "/Users/lirdoron/Desktop/PSTAT132HW1/PSTAT132-db.sqlite"
)

# Create the products table only if it doesn't already exist
dbExecute(PSTAT132db, "
  CREATE TABLE IF NOT EXISTS products (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT,
    category TEXT,
    price REAL
  );
")

# Insert the five sample products only if the table is empty
n_products <- dbGetQuery(
  PSTAT132db,
  "SELECT COUNT(*) AS n FROM products"
)$n[1]

if (n_products == 0) {
  dbExecute(PSTAT132db, "
    INSERT INTO products (product_id, product_name, category, price)
    VALUES
      (1, 'Laptop', 'Electronics', 1200.00),
      (2, 'Desk Chair', 'Furniture', 150.50),
      (3, 'Wireless Mouse', 'Electronics', 25.99),
      (4, 'Notebook', 'Stationery', 5.00),
      (5, 'Monitor', 'Electronics', 300.00);
  ")
}

# Check that all three tables exist
dbListTables(PSTAT132db)

# Display the products
dbGetQuery(PSTAT132db, "SELECT * FROM products")






DBI::dbDisconnect(PSTAT132db)
PSTAT132db <- dbConnect(
  RSQLite::SQLite(),
  "/Users/lirdoron/Desktop/PSTAT132HW1/PSTAT132-db.sqlite"
)
dbWriteTable(PSTAT132db, "customers", customers, overwrite = TRUE)
dbWriteTable(PSTAT132db, "orders", orders, overwrite = TRUE)
dbListTables(PSTAT132db)
# Demo 1
# Create a new database PSTAT132.
PSTAT132db <- dbConnect(RSQLite::SQLite(), "PSTAT132-db.sqlite")
# Create a table named 'products' using dbExecute.
dbExecute(PSTAT132db, "
CREATE TABLE products (
product_id INTEGER PRIMARY KEY,
product_name TEXT,
category TEXT,
price REAL
);
")
message("Table 'products' created.")
# Insert data into the products table
dbExecute(PSTAT132db, "
INSERT INTO products (product_id, product_name, category, price)
VALUES
(1, 'Laptop', 'Electronics', 1200.00),
(2, 'Desk Chair', 'Furniture', 150.50),
(3, 'Wireless Mouse', 'Electronics', 25.99),
(4, 'Notebook', 'Stationery', 5.00),
(5, 'Monitor', 'Electronics', 300.00);
")
message("Five rows inserted into 'products'.")
# Create 2 tibbles and add to the database. Just an alternative.
# Create three two tables (customers and orders)
customers <- tibble(
  customer_id = 1:6,
  name = c("Ava", "Ben", "Chi", "Dee", "Eli", "Faye"),
  region = c("North","South","North","West","South","East")
)
orders <- tibble(
  order_id = 1:12,
  customer_id = c(1,2,1,3,4,2,5,6,1,3,5,2),
  product_id = c(1,2,1,3,4,2,1,4,3,2,1,1),
  order_date = as.Date("2023-01-01") + c(0,2,5,7,10,11,12,14,15,18,20,22),
  amount = c(120, 55, 80, 40, 200, 30, 90, 160, 35, 75, 60, 95),
  notes = c(NA, "gift", "promo", NA, "RETURNED", NA, "gift", "bulk", NA, NA, "promo", "gift"))
# Write the tibbles to the database (overwrite if already present)
dbWriteTable(PSTAT132db, "customers", customers, overwrite = TRUE)
dbWriteTable(PSTAT132db, "orders", orders, overwrite = TRUE)
# Inspecting the database. Use
# Inspecting the database. Use single or double quotes. Be consistent.
dbListTables(PSTAT132db) # list table names
dbListFields(PSTAT132db, "products") # list columns in orders
dbGetQuery(PSTAT132db, 'SELECT * FROM products')
dbGetQuery(PSTAT132db, "PRAGMA table_info('products')") # schema + types for orders
is.data.frame(products)
# Demo 2
# Basic SQL queries via DBI
# Retrieve all columns and all rows
all_products <- dbGetQuery(PSTAT132db, "SELECT * FROM products;")
print(all_products)
# Retrieve just the names and category
names_and_categories <- dbGetQuery(PSTAT132db, "SELECT product_name, category FROM products;")
print(names_and_categories)
# Filter using WHERE
expensive_items <- dbGetQuery(PSTAT132db, "
SELECT product_name, price
FROM products
WHERE price > 100.00;
")
print(expensive_items)
# Sort using ORDER BY
sorted_products <- dbGetQuery(PSTAT132db, "
SELECT *
FROM products
ORDER BY price DESC;
")
print(sorted_products)
# Find the top 1 most expensive item using ORDER BY and LIMIT
top_item <- dbGetQuery(PSTAT132db, "
SELECT product_name, price
FROM products
ORDER BY price DESC
LIMIT 1;
")
print(top_item)


# Complex filtering
complex_query <- dbGetQuery(PSTAT132db, "
SELECT product_name, category, price
FROM products
WHERE (category = 'Electronics' AND price < 500.00)
OR product_name LIKE '%Note%';
")
print(complex_query)
# Demo 3
# Filtered query (WHERE) and sorting (ORDER BY)
q2 <- dbGetQuery(PSTAT132db, "
SELECT o.order_id, o.order_date, o.amount, c.name AS customer
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE amount > 80
ORDER BY amount DESC
")
print(q2)
# Aggregation: total sales by region (GROUP BY + HAVING)
q3 <- dbGetQuery(PSTAT132db, "
SELECT c.region, SUM(o.amount) AS total_sales, COUNT(*) AS n_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.region
HAVING SUM(o.amount) > 150
ORDER BY total_sales DESC
")
print(q3)
# Demo 4
# Recall dplyr for manipulating in-memory data frames.
# EXAMPLE using the 'mtcars' dataset.
library(dplyr)
# 1. Filter rows, select columns, create new variables, and sort
EXAMPLE_df <- mtcars %>%
  filter(mpg > 20) %>% # Keep cars with > 20 MPG
  select(mpg, cyl, hp) %>% # Keep only these columns
  mutate(hp_per_cyl = hp / cyl) %>% # Create a new calculated column
  arrange(desc(hp_per_cyl)) # Sort by the new column descending
print(EXAMPLE_df)
# Demo 5
# Use dbplyr: create remote table references and compose a query
orders_tbl <- tbl(PSTAT132db, "orders")
customers_tbl <- tbl(PSTAT132db, "customers")
products_tbl <- tbl(PSTAT132db, "products")
# Compose a query in dplyr and show the SQL that will be executed
q_dplyr <- orders_tbl %>%
  inner_join(customers_tbl, by = "customer_id") %>%
  inner_join(products_tbl, by = "product_id") %>%
  filter(amount > 50, category == "Electronics") %>%
  select(order_id, order_date, name, product_name, amount) %>%
  arrange(desc(amount)) %>%
  head(10)
show_query(q_dplyr) # display SQL that dbplyr generates
df_dplyr <- q_dplyr %>% collect() # execute on DB and pull into R
print(df_dplyr)
ggplot(monthly_sales, aes(x = ym, y = total_sales, group = 1)) +
  geom_line() + geom_point() +
  labs(x = "Year-Month", y = "Total sales", title = "Monthly sales (sample DB)") +
  theme_minimal ()
# Demo 6
# Write a new R data frame to DB
# Example: customer_totals
customer_totals <- dbGetQuery(PSTAT132db, "
SELECT c.customer_id, c.name, SUM(o.amount) AS total_spend
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
") %>% as_tibble()
customer_totals
# Disconnect
DBI::dbDisconnect(PSTAT132db)
message("PSTAT 132db Disconnected.")
# Demo 7
# Another example.
# Create a temporary (in Memory ) database
# Creates a connection to an in-memory SQLite database.
# The database exists only while the R session is running.
example7 <- dbConnect( SQLite(),":memory:")
# Write customer data and pipe as a tibble
customers <- data.frame(
  customer_id = c(1, 2, 3, 4),
  customer_name = c(
    "Alice Johnson",
    "Brian Smith",
    "Carla Davis",
    "Daniel Lee"
  ),
  state = c("CA", "NY", "CA", "TX"),
  stringsAsFactors = FALSE
)
dbWriteTable(example7, customers,
             name = "customers",
             value = customers,
             overwrite = TRUE
)
california_customers_tibble <- tbl(example7, "customers") |>
  filter(state == "CA") |>
  select(customer_id, customer_name, state) |>
  collect() |>
  as_tibble()
california_customers_tibble
# END LECTURE 1 DEMOS

