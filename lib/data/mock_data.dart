import '../models/product.dart';

final List<Map<String, dynamic>> mockProductsJson = [
  {
    "id": 1,
    "title": "Slim Fit Erkek Gömlek",
    "description": "Yüksek kaliteli pamuklu kumaştan üretilmiş slim fit gömlek.",
    "price": 349.90,
    "category": "Giyim",
    "image": "https://images.unsplash.com/photo-1598033129183-c4f50c736f10?w=400",
    "rating": {"rate": 4.5}
  },
  {
    "id": 2,
    "title": "Kablosuz Kulaklık",
    "description": "Bluetooth 5.0, 30 saat pil ömrü, aktif gürültü engelleme.",
    "price": 899.00,
    "category": "Elektronik",
    "image": "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400",
    "rating": {"rate": 4.8}
  },
  {
    "id": 3,
    "title": "Deri Cüzdan",
    "description": "El yapımı hakiki deri, 8 kart bölmesi.",
    "price": 279.50,
    "category": "Aksesuar",
    "image": "https://images.unsplash.com/photo-1627123424574-724758594e93?w=400",
    "rating": {"rate": 4.3}
  },
  {
    "id": 4,
    "title": "Spor Ayakkabı",
    "description": "Hafif taban, ergonomik tasarım, günlük kullanım.",
    "price": 1199.00,
    "category": "Ayakkabı",
    "image": "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400",
    "rating": {"rate": 4.6}
  },
  {
    "id": 5,
    "title": "Akıllı Saat",
    "description": "Kalp ritmi, uyku analizi, IP68 su geçirmez.",
    "price": 2499.00,
    "category": "Elektronik",
    "image": "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400",
    "rating": {"rate": 4.7}
  },
  {
    "id": 6,
    "title": "Kadın Elbise",
    "description": "Şık midi elbise, %100 viskon kumaş.",
    "price": 549.90,
    "category": "Giyim",
    "image": "https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=400",
    "rating": {"rate": 4.2}
  },
  {
    "id": 7,
    "title": "Laptop Çantası",
    "description": "15.6 inç uyumlu, su geçirmez, çok bölmeli.",
    "price": 459.00,
    "category": "Çanta",
    "image": "https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400",
    "rating": {"rate": 4.4}
  },
  {
    "id": 8,
    "title": "Güneş Gözlüğü",
    "description": "UV400 korumalı polarize cam, unisex model.",
    "price": 389.00,
    "category": "Aksesuar",
    "image": "https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=400",
    "rating": {"rate": 4.1}
  },
];

List<Product> getMockProducts() {
  return mockProductsJson.map((json) => Product.fromJson(json)).toList();
}

List<String> getCategories() {
  final products = getMockProducts();
  final categories = products.map((p) => p.category).toSet().toList();
  return ['Tümü', ...categories];
}