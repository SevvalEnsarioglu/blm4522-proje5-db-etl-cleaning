-- 1. NULL değer analizi - customers
SELECT 
    COUNT(*) as toplam,
    COUNT(*) FILTER (WHERE company_name IS NULL) as bos_sirket,
    COUNT(*) FILTER (WHERE contact_name IS NULL) as bos_iletisim,
    COUNT(*) FILTER (WHERE city IS NULL) as bos_sehir,
    COUNT(*) FILTER (WHERE country IS NULL) as bos_ulke,
    COUNT(*) FILTER (WHERE phone IS NULL) as bos_telefon,
    COUNT(*) FILTER (WHERE postal_code IS NULL) as bos_posta_kodu
FROM staging.customers;

-- 2. NULL değer analizi - orders
SELECT
    COUNT(*) as toplam,
    COUNT(*) FILTER (WHERE customer_id IS NULL) as bos_musteri,
    COUNT(*) FILTER (WHERE ship_city IS NULL) as bos_sehir,
    COUNT(*) FILTER (WHERE ship_country IS NULL) as bos_ulke,
    COUNT(*) FILTER (WHERE shipped_date IS NULL) as bos_kargo_tarihi
FROM staging.orders;

-- 3. NULL değer analizi - products
SELECT
    COUNT(*) as toplam,
    COUNT(*) FILTER (WHERE product_name IS NULL) as bos_urun_adi,
    COUNT(*) FILTER (WHERE unit_price IS NULL) as bos_fiyat,
    COUNT(*) FILTER (WHERE units_in_stock IS NULL) as bos_stok
FROM staging.products;

-- 4. Duplicate kontrolü - customers
SELECT company_name, COUNT(*) 
FROM staging.customers 
GROUP BY company_name 
HAVING COUNT(*) > 1;

-- 5. Negatif/sıfır fiyat kontrolü - products
SELECT product_id, product_name, unit_price 
FROM staging.products 
WHERE unit_price <= 0 OR unit_price IS NULL;

-- 6. Negatif miktar/fiyat kontrolü - order_details
SELECT * FROM staging.order_details 
WHERE quantity <= 0 OR unit_price < 0;

-- 7. Geçersiz tarih aralığı - orders
SELECT order_id, order_date, shipped_date 
FROM staging.orders 
WHERE shipped_date < order_date;

-- 8. Tutarsız ülke/şehir - customers (boşluk, büyük/küçük harf)
SELECT customer_id, company_name, country, city
FROM staging.customers
WHERE country != TRIM(country) 
   OR city != TRIM(city)
   OR country != INITCAP(country);
