# Proje 5: Veri Temizleme ve ETL Süreçleri Tasarımı

> 22290742 - ŞEVVAL ENSARİOĞLU    
> **Video Linki:** *[Video linki buraya eklenecek]*

---

## Proje Hakkında

Bu projede büyük veri kümelerinin temizlenmesi ve işlenmesi için ETL (Extract, Transform, Load) süreçleri oluşturulmuştur. Proje kapsamında hatalı ve tutarsız verilerin tespiti, verilerin standartlaştırılması, dönüştürülmesi ve temizlenen verilerin hedef veri ambarına (Data Warehouse) yüklenmesi gibi görevler ele alınmıştır.

---

## Proje Yapısı

- **`sql/`**: ETL sürecine ait SQL kodları.
  - `01_veri_cekme_ve_staging.sql`: Ana veritabanından verilerin çekilerek geçici (staging) tablolara aktarılması.
  - `02_veri_analizi_ve_hatalarin_tespiti.sql`: Boş, hatalı veya tekrarlayan verilerin tespit edilmesi (Profil çıkarma).
  - `03_veri_temizleme_ve_donusturme.sql`: Verilerin standartlaştırılması (TRIM, INITCAP) ve tutarsızlıkların giderilmesi.
  - `04_veri_yukleme_warehouse.sql`: Temizlenmiş verilerin nihai veri ambarına (warehouse) yüklenmesi.
  - `05_veri_kalitesi_raporlari.sql`: Süreç sonunda veri kalitesi özetlerinin ve analiz raporlarının oluşturulması.
- **`rapor/`**: Projeye ait dokümantasyon ve rapor dosyaları.
- **`ekran_goruntuleri/`**: İşlem adımları ve veri kalitesi raporlarının görsel çıktıları.

---

## Öne Çıkan ETL Adımları

### 1. Veri Çekme (Extract) ve Staging
Ana tablolardaki veriler üzerinde doğrudan işlem yapmamak adına geçici bir `staging` şeması oluşturulmuş ve tüm analiz/temizleme işlemleri bu yalıtılmış ortamda gerçekleştirilmiştir.

### 2. Veri Temizleme (Cleaning)
- `NULL` değerler analiz edilerek duruma göre "Unknown" veya "N/A" gibi uygun ifadelerle doldurulmuştur.
- Tekrarlayan (Duplicate) kayıtlar tespit edilmiş, hatalı tarih aralıkları (Örn: Sipariş tarihinden önce gelen kargo tarihleri) düzeltilmiştir.
- Negatif stok sayıları veya sıfır/negatif fiyatlı ürünler gibi mantıksal veri hataları sıfırlanmış veya ortalama değerler kullanılarak onarılmıştır.

### 3. Veri Dönüştürme (Transformation)
Metin tabanlı alanlardaki yazım yanlışlıklarını ve tutarsızlıkları önlemek için gereksiz boşluklar `TRIM` fonksiyonu ile temizlenmiş, şehir ve ülke gibi isimler `INITCAP` fonksiyonu kullanılarak sadece ilk harfleri büyük olacak şekilde standart formata getirilmiştir.

### 4. Veri Yükleme (Load) ve Veri Kalitesi Raporları
Tüm temizleme ve dönüştürme işlemleri tamamlandıktan sonra veriler kalıcı olarak `warehouse` şemasına aktarılmıştır. Son olarak, kaynak tablo ile ambar tablosu arasındaki veri kayıp oranlarını ve ülke/kategori bazlı şirket metriklerini veren veri kalitesi raporları oluşturulmuştur.
