// lib/screens/product_detail_screen.dart

import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final Cart _cart = Cart();
  bool _addedToCart = false;

  void _toggleCart() {
    setState(() {
      if (_cart.contains(widget.product.id)) {
        _cart.removeProduct(widget.product.id);
        _addedToCart = false;
      } else {
        _cart.addProduct(widget.product);
        _addedToCart = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _addedToCart = _cart.contains(widget.product.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          // Üst görsel alanı
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            backgroundColor: const Color(0xFF2C3E50),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(Icons.shopping_cart_outlined,
                        color: Colors.white),
                    if (_cart.itemCount > 0)
                      Positioned(
                        top: 4,
                        right: 0,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: const BoxDecoration(
                            color: Colors.amber,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              _cart.itemCount.toString(),
                              style: const TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const CartScreen()));
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(32),
                child: Image.network(
                  widget.product.imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(
                      Icons.image_not_supported,
                      size: 80,
                      color: Colors.grey),
                ),
              ),
            ),
          ),
          // Ürün detayları
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kategori
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C3E50).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      widget.product.category,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Ürün adı
                  Text(
                    widget.product.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF2C3E50),
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Puan
                  Row(
                    children: [
                      ...List.generate(5, (i) {
                        return Icon(
                          i < widget.product.rating.floor()
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                          size: 20,
                        );
                      }),
                      const SizedBox(width: 8),
                      Text(
                        '${widget.product.rating} / 5.0',
                        style: const TextStyle(
                            fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Fiyat
                  Row(
                    children: [
                      Text(
                        '₺${widget.product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFE74C3C),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Ayırıcı
                  const Divider(color: Color(0xFFECF0F1), thickness: 2),
                  const SizedBox(height: 16),
                  // Açıklama başlığı
                  const Text(
                    'Ürün Açıklaması',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.product.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF7F8C8D),
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Sepete ekle butonu
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton.icon(
                      onPressed: _toggleCart,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _addedToCart
                            ? const Color(0xFF27AE60)
                            : const Color(0xFF2C3E50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      icon: Icon(
                        _addedToCart ? Icons.check : Icons.add_shopping_cart,
                        color: Colors.white,
                      ),
                      label: Text(
                        _addedToCart ? 'Sepetten Çıkar' : 'Sepete Ekle',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
