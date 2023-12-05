-- Создание базы данных
CREATE DATABASE auto_workshop;
\c auto_workshop;

-- Создание таблицы для клиентов
CREATE TABLE clients (
    client_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone_number VARCHAR(15),
    email VARCHAR(100),
    address VARCHAR(255)
);

-- Создание таблицы для автомобилей
CREATE TABLE cars (
    car_id SERIAL PRIMARY KEY,
    client_id INT REFERENCES clients(client_id),
    make VARCHAR(50),
    model VARCHAR(50),
    year INT,
    license_plate VARCHAR(20),
    vin_number VARCHAR(50)
);

-- Создание таблицы для заказов
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    car_id INT REFERENCES cars(car_id),
    order_date DATE,
    service_description TEXT,
    total_cost DECIMAL(10, 2)
);

-- Создание представления для отображения информации о заказах с подробностями о клиентах и автомобилях
CREATE VIEW order_details AS
SELECT
    o.order_id,
    o.order_date,
    o.service_description,
    o.total_cost,
    c.first_name || ' ' || c.last_name AS client_name,
    c.phone_number,
    c.email,
    ca.make,
    ca.model,
    ca.year,
    ca.license_plate,
    ca.vin_number
FROM
    orders o
JOIN
    cars ca ON o.car_id = ca.car_id
JOIN
    clients c ON ca.client_id = c.client_id;

-- Создание таблицы сотрудников
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    position VARCHAR(50),
    phone_number VARCHAR(15),
    email VARCHAR(100)
);

-- Создание таблицы услуг
CREATE TABLE services (
    service_id SERIAL PRIMARY KEY,
    service_name VARCHAR(100),
    description TEXT,
    cost DECIMAL(10, 2)
);

-- Расширение таблицы заказов для учета сотрудников и услуг
ALTER TABLE orders
ADD COLUMN employee_id INT REFERENCES employees(employee_id),
ADD COLUMN service_id INT REFERENCES services(service_id);

-- Создание таблицы для запасных частей
CREATE TABLE parts (
    part_id SERIAL PRIMARY KEY,
    part_name VARCHAR(100),
    description TEXT,
    cost DECIMAL(10, 2)
);

-- Создание таблицы, связывающей заказы с запасными частями
CREATE TABLE order_parts (
    order_id INT REFERENCES orders(order_id),
    part_id INT REFERENCES parts(part_id),
    quantity INT,
    PRIMARY KEY (order_id, part_id)
);


-- Вставка тестовых данных в таблицу клиентов
INSERT INTO clients (first_name, last_name, phone_number, email, address)
VALUES
    ('John', 'Doe', '123-456-7890', 'john.doe@example.com', '123 Main St'),
    ('Jane', 'Smith', '987-654-3210', 'jane.smith@example.com', '456 Oak St');

-- Вставка тестовых данных в таблицу сотрудников
INSERT INTO employees (first_name, last_name, position, phone_number, email)
VALUES
    ('Mike', 'Johnson', 'Mechanic', '555-123-4567', 'mike.johnson@example.com'),
    ('Emily', 'Davis', 'Service Manager', '555-987-6543', 'emily.davis@example.com');

-- Вставка тестовых данных в таблицу услуг
INSERT INTO services (service_name, description, cost)
VALUES
    ('Oil Change', 'Replace engine oil and oil filter', 29.99),
    ('Brake Inspection', 'Inspect and adjust brakes', 19.99),
    ('Tire Rotation', 'Rotate tires for even wear', 14.99);

-- Вставка тестовых данных в таблицу запасных частей
INSERT INTO parts (part_name, description, cost)
VALUES
    ('Brake Pads', 'Front brake pads', 39.99),
    ('Air Filter', 'Engine air filter', 9.99),
    ('Spark Plugs', 'Set of spark plugs', 19.99);

-- Вставка тестовых данных в таблицу автомобилей
INSERT INTO cars (client_id, make, model, year, license_plate, vin_number)
VALUES
    (1, 'Toyota', 'Camry', 2018, 'ABC123', '1234567890'),
    (2, 'Honda', 'Civic', 2020, 'XYZ789', '0987654321');

-- Вставка тестовых данных в таблицу заказов
INSERT INTO orders (car_id, order_date, service_description, total_cost, employee_id, service_id)
VALUES
    (1, '2023-01-15', 'Oil Change and Brake Inspection', 49.98, 1, 1),
    (2, '2023-02-01', 'Tire Rotation', 14.99, 2, 3);

-- Вставка тестовых данных в таблицу, связывающую заказы с запасными частями
INSERT INTO order_parts (order_id, part_id, quantity)
VALUES
    (1, 1, 2),
    (2, 3, 1);
