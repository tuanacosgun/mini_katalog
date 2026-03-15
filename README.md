# 🛍 Mini Katalog Uygulaması

Flutter ile geliştirilmiş, eğitim amaçlı basit bir mobil katalog uygulaması. Version:(Flutter 3.41.3)

---

## 📱 Uygulama Hakkında

Bu proje, Flutter Günlük Eğitimi kapsamında geliştirilen **Mini Katalog Uygulaması**'dır.
Kullanıcılar ürünleri listeleyebilir, filtreleyebilir, detay sayfasını görüntüleyebilir ve sepete ekleyebilir.

---

## ✨ Özellikler

- 🏠 **Ana Sayfa** – GridView ile ürün listesi
- 🔍 **Arama & Filtreleme** – Ürün adına ve kategoriye göre anlık filtreleme
- 📋 **Ürün Detayı** – Tam açıklama, puan, fiyat ve görselle detay sayfası
- 🛒 **Sepet Sistemi** – Ürün ekle/çıkar, adet güncelleme, toplam fiyat
- 🗺 **Navigasyon** – Navigator.push/pop + Named Routes
- 💾 **Model Yapısı** – fromJson/toJson ile JSON simülasyonu

---

## 🗂 Proje Klasör Yapısı

```
lib/
├── main.dart                    # Uygulama girişi + Route tanımları
├── models/
│   ├── product.dart             # Product model sınıfı (fromJson/toJson)
│   └── cart.dart                # Sepet yönetimi (Singleton pattern)
├── data/
│   └── mock_data.dart           # JSON simülasyon verisi
├── screens/
│   ├── home_screen.dart         # Ana sayfa (GridView + arama + filtre)
│   ├── product_detail_screen.dart  # Ürün detay sayfası
│   └── cart_screen.dart         # Sepet sayfası
└── widgets/
    ├── product_card.dart        # Ürün kart bileşeni
    ├── search_bar_widget.dart   # Arama kutusu
    └── category_filter.dart    # Kategori filtre chips
```

---

## 🛠 Kullanılan Araçlar

| Araç | Versiyon |
|------|----------|
| Flutter SDK | 3.41.3|
| Dart SDK | 3.11.1 |

> **Not:** Ekstra paket kullanılmamıştır. Yalnızca `material.dart` kullanılmıştır.

---

## 🚀 Çalıştırma Adımları

### Ön Gereksinimler
- Flutter SDK kurulu olmalı → [flutter.dev](https://flutter.dev)
- Android Studio veya VS Code kurulu olmalı
- Android Emulator veya fiziksel Android cihaz hazır olmalı

### Adımlar

```bash
# 1. Projeyi klonlayın
git clone https://github.com/KULLANICI_ADI/mini_katalog.git

# 2. Proje dizinine girin
cd mini_katalog

# 3. Bağımlılıkları yükleyin
flutter pub get

# 4. Emulator veya cihazı başlatın
# (Android Studio üzerinden veya terminal ile)

# 5. Uygulamayı çalıştırın
flutter run
```

---

## 📸 Ekran Görüntüleri

> *Ekran görüntüleri "screenshots" dosyasında bulunmaktadır.*

---

## 📚 Öğrenilen Konular

- ✅ Stateless & Stateful Widget
- ✅ Widget ağacı ve Context
- ✅ GridView.builder ile dinamik liste
- ✅ Navigator.push / pop & Named Routes
- ✅ Route Arguments ile sayfalar arası veri taşıma
- ✅ JSON modeli (fromJson / toJson)
- ✅ Arama ve filtreleme mantığı
- ✅ setState ile basit state yönetimi
- ✅ Asset ve Image.network kullanımı

---

## 📄 Lisans

Bu proje eğitim amaçlıdır ve açık kaynaklıdır.
