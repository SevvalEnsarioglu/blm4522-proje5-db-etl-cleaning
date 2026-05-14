-- 1. Boşlukları temizle (TRIM)
UPDATE staging.customers SET
    company_name  = TRIM(company_name),
    contact_name  = TRIM(contact_name),
    city          = TRIM(city),
    country       = TRIM(country),
    phone         = TRIM(phone);

UPDATE staging.suppliers SET
    company_name  = TRIM(company_name),
    contact_name  = TRIM(contact_name),
    city          = TRIM(city),
    country       = TRIM(country);

UPDATE staging.products SET
    product_name  = TRIM(product_name);

-- 2. Ülke/şehir standardizasyonu (ilk harf büyük)
UPDATE staging.customers SET
    country = INITCAP(country),
    city    = INITCAP(city);

UPDATE staging.suppliers SET
    country = INITCAP(country),
    city    = INITCAP(city);

-- 3. NULL şehirleri 'Unknown' yap
UPDATE staging.customers 
SET city = 'Unknown' 
WHERE city IS NULL;

UPDATE staging.orders 
SET ship_city = 'Unknown' 
WHERE ship_city IS NULL;

-- 4. NULL ülkeleri 'Unknown' yap
UPDATE staging.customers 
SET country = 'Unknown' 
WHERE country IS NULL;

-- 5. NULL posta kodlarını 'N/A' yap
UPDATE staging.customers 
SET postal_code = 'N/A' 
WHERE postal_code IS NULL;

-- 6. Negatif stok değerlerini 0 yap
UPDATE staging.products 
SET units_in_stock = 0 
WHERE units_in_stock < 0;

-- 7. NULL fiyatları ortalama ile doldur
UPDATE staging.products
SET unit_price = (SELECT AVG(unit_price) FROM staging.products WHERE unit_price IS NOT NULL)
WHERE unit_price IS NULL;

-- 8. Kargo tarihi sipariş tarihinden önce olanları düzelt
UPDATE staging.orders
SET shipped_date = order_date
WHERE shipped_date < order_date;
