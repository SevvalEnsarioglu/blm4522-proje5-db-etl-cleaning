SELECT table_name, 
       (SELECT COUNT(*) FROM information_schema.columns 
        WHERE table_name = t.table_name) as kolon_sayisi
FROM information_schema.tables t
WHERE table_schema = 'public'
ORDER BY table_name;

SELECT 'customers'    AS tablo, COUNT(*) AS kayit_sayisi FROM customers
UNION ALL
SELECT 'orders',                COUNT(*) FROM orders
UNION ALL
SELECT 'order_details',         COUNT(*) FROM order_details
UNION ALL
SELECT 'products',              COUNT(*) FROM products
UNION ALL
SELECT 'suppliers',             COUNT(*) FROM suppliers;

-- Schema'ları oluştur
CREATE SCHEMA IF NOT EXISTS staging;
CREATE SCHEMA IF NOT EXISTS warehouse;

-- Staging tablolarını oluştur (public'ten kopyalayacağız)
CREATE TABLE staging.customers    AS SELECT * FROM public.customers    WITH NO DATA;
CREATE TABLE staging.orders       AS SELECT * FROM public.orders       WITH NO DATA;
CREATE TABLE staging.order_details AS SELECT * FROM public.order_details WITH NO DATA;
CREATE TABLE staging.products     AS SELECT * FROM public.products     WITH NO DATA;
CREATE TABLE staging.suppliers    AS SELECT * FROM public.suppliers    WITH NO DATA;

-- Public'ten staging'e veriyi kopyala
INSERT INTO staging.customers    SELECT * FROM public.customers;
INSERT INTO staging.orders       SELECT * FROM public.orders;
INSERT INTO staging.order_details SELECT * FROM public.order_details;
INSERT INTO staging.products     SELECT * FROM public.products;
INSERT INTO staging.suppliers    SELECT * FROM public.suppliers;
