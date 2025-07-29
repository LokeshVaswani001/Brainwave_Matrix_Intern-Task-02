-- Drop tables if they exist (drop children before parents due to foreign keys)
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

-- Create database
CREATE DATABASE IF NOT EXISTS estore;
USE estore;

-- Table: Customers
CREATE TABLE customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100),
  address TEXT
);

-- Table: Products
CREATE TABLE products (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  description TEXT,
  price DECIMAL(10,2),
  stock INT
);

-- Table: Orders
CREATE TABLE orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT,
  order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Table: Order Items
CREATE TABLE order_items (
  item_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  product_id INT,
  quantity INT,
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Table: Payments
CREATE TABLE payments (
  payment_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  amount DECIMAL(10,2),
  payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  method VARCHAR(50),
  FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Insert Sample Customers
INSERT INTO customers (name, email, address) VALUES
('Ali Khan', 'ahmed@example.com', 'Karachi'),
('Sara Malik', 'ayesha@example.com', 'Lahore');

-- Insert Sample Products
INSERT INTO products (name, description, price, stock) VALUES
('Laptop', 'Gaming Laptop', 120000, 10),
('Mobile Phone', 'Smartphone 5G', 60000, 20);

-- Insert a Sample Order
INSERT INTO orders (customer_id) VALUES (1);

-- Insert Order Items
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 2, 2);

-- Insert Payment
INSERT INTO payments (order_id, amount, method) VALUES
(1, 180000, 'Credit Card');

-- Sample Query 1: Show all orders with customer name and total amount
SELECT o.order_id, c.name AS customer_name, SUM(p.price * oi.quantity) AS total
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY o.order_id;

-- Sample Query 2: Check available stock
SELECT name, stock FROM products;

-- Sample Query 3: List all payments
SELECT * FROM payments;
