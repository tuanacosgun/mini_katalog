// lib/models/product.dart

class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String category;
  final String imageUrl;
  final double rating;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.rating,
  });

  // JSON'dan model oluşturma
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      category: json['category'] as String,
      imageUrl: json['image'] as String,
      rating: (json['rating']['rate'] as num).toDouble(),
    );
  }

  // Model'den JSON oluşturma
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'category': category,
      'image': imageUrl,
      'rating': {'rate': rating},
    };
  }
}
