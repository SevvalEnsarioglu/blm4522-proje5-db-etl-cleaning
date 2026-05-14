-- Genel özet rapor
SELECT 'customers' AS tablo,
    (SELECT COUNT(*) FROM public.customers)   AS kaynak_kayit,
    (SELECT COUNT(*) FROM warehouse.customers) AS temiz_kayit,
    (SELECT COUNT(*) FROM public.customers) - 
    (SELECT COUNT(*) FROM warehouse.customers) AS fark
UNION ALL
SELECT 'orders',
    (SELECT COUNT(*) FROM public.orders),
    (SELECT COUNT(*) FROM warehouse.orders),
    (SELECT COUNT(*) FROM public.orders) - (SELECT COUNT(*) FROM warehouse.orders)
UNION ALL
SELECT 'order_details',
    (SELECT COUNT(*) FROM public.order_details),
    (SELECT COUNT(*) FROM warehouse.order_details),
    (SELECT COUNT(*) FROM public.order_details) - (SELECT COUNT(*) FROM warehouse.order_details)
UNION ALL
SELECT 'products',
    (SELECT COUNT(*) FROM public.products),
    (SELECT COUNT(*) FROM warehouse.products),
    (SELECT COUNT(*) FROM public.products) - (SELECT COUNT(*) FROM warehouse.products)
UNION ALL
SELECT 'suppliers',
    (SELECT COUNT(*) FROM public.suppliers),
    (SELECT COUNT(*) FROM warehouse.suppliers),
    (SELECT COUNT(*) FROM public.suppliers) - (SELECT COUNT(*) FROM warehouse.suppliers);

-- NULL düzeltme raporu
SELECT
    'NULL şehir düzeltilen (customers)' AS islem,
    COUNT(*) AS adet
FROM warehouse.customers WHERE city = 'Unknown'
UNION ALL
SELECT
    'NULL ülke düzeltilen (customers)',
    COUNT(*) FROM warehouse.customers WHERE country = 'Unknown'
UNION ALL
SELECT
    'NULL posta kodu düzeltilen',
    COUNT(*) FROM warehouse.customers WHERE postal_code = 'N/A'
UNION ALL
SELECT
    'Sıfırlanan negatif stok (products)',
    COUNT(*) FROM warehouse.products WHERE units_in_stock = 0;

-- Ülke bazlı müşteri dağılımı (temiz veri)
SELECT country, COUNT(*) as musteri_sayisi
FROM warehouse.customers
GROUP BY country
ORDER BY musteri_sayisi DESC;

-- Kategori bazlı ürün ve ortalama fiyat raporu
SELECT 
    c.category_name,
    COUNT(p.product_id) as urun_sayisi,
    ROUND(AVG(p.unit_price)::numeric, 2) as ort_fiyat,
    SUM(p.units_in_stock) as toplam_stok
FROM warehouse.products p
JOIN public.categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY urun_sayisi DESC;

-- Yıllık sipariş trendi
SELECT 
    EXTRACT(YEAR FROM order_date) as yil,
    COUNT(*) as siparis_sayisi,
    ROUND(SUM(od.unit_price * od.quantity)::numeric, 2) as toplam_ciro
FROM warehouse.orders o
JOIN warehouse.order_details od ON o.order_id = od.order_id
GROUP BY yil
ORDER BY yil;
