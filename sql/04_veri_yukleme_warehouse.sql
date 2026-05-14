-- Warehouse tablolarını oluştur
CREATE TABLE warehouse.customers    AS SELECT * FROM staging.customers    WITH NO DATA;
CREATE TABLE warehouse.orders       AS SELECT * FROM staging.orders       WITH NO DATA;
CREATE TABLE warehouse.order_details AS SELECT * FROM staging.order_details WITH NO DATA;
CREATE TABLE warehouse.products     AS SELECT * FROM staging.products     WITH NO DATA;
CREATE TABLE warehouse.suppliers    AS SELECT * FROM staging.suppliers    WITH NO DATA;

-- Temiz veriyi yükle
INSERT INTO warehouse.customers    SELECT * FROM staging.customers;
INSERT INTO warehouse.orders       SELECT * FROM staging.orders;
INSERT INTO warehouse.order_details SELECT * FROM staging.order_details;
INSERT INTO warehouse.products     SELECT * FROM staging.products;
INSERT INTO warehouse.suppliers    SELECT * FROM staging.suppliers;
