// lib/screens/cart_screen.dart

import 'package:flutter/material.dart';
import '../models/cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final Cart _cart = Cart();

  void _increaseQuantity(int productId) {
    setState(() {
      final item =
          _cart.items.firstWhere((i) => i.product.id == productId);
      _cart.addProduct(item.product);
    });
  }

  void _decreaseQuantity(int productId) {
    setState(() {
      _cart.decreaseQuantity(productId);
    });
  }

  void _removeItem(int productId) {
    setState(() {
      _cart.removeProduct(productId);
    });
  }

  void _clearCart() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Sepeti Temizle',
            style: TextStyle(fontWeight: FontWeight.w700)),
        content: const Text('Sepetteki tüm ürünler kaldırılsın mı?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('İptal',
                style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => _cart.clear());
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE74C3C),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Temizle',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C3E50),
        elevation: 0,
        title: Text(
          'Sepetim (${_cart.itemCount} ürün)',
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (_cart.items.isNotEmpty)
            TextButton.icon(
              onPressed: _clearCart,
              icon: const Icon(Icons.delete_sweep,
                  color: Colors.white70, size: 18),
              label: const Text('Temizle',
                  style: TextStyle(color: Colors.white70, fontSize: 13)),
            ),
        ],
      ),
      body: _cart.items.isEmpty
          ? _buildEmptyCart()
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _cart.items.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 10),
                    itemBuilder: (_, index) {
                      final item = _cart.items[index];
                      return _buildCartItem(item);
                    },
                  ),
                ),
                _buildOrderSummary(),
              ],
            ),
    );
  }

  Widget _buildEmptyCart() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.shopping_cart_outlined,
              size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Sepetiniz boş',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2C3E50)),
          ),
          SizedBox(height: 8),
          Text(
            'Ürün eklemek için alışverişe devam edin',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(CartItem item) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Ürün görseli
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              item.product.imageUrl,
              width: 70,
              height: 70,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.image, size: 50, color: Colors.grey),
            ),
          ),
          const SizedBox(width: 12),
          // Ürün bilgisi
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2C3E50)),
                ),
                const SizedBox(height: 4),
                Text(
                  '₺${item.product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFE74C3C)),
                ),
              ],
            ),
          ),
          // Adet kontrol
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.delete_outline,
                    color: Color(0xFFE74C3C), size: 20),
                onPressed: () => _removeItem(item.product.id),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _quantityButton(
                    icon: Icons.remove,
                    onTap: () => _decreaseQuantity(item.product.id),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    item.quantity.toString(),
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2C3E50)),
                  ),
                  const SizedBox(width: 8),
                  _quantityButton(
                    icon: Icons.add,
                    onTap: () => _increaseQuantity(item.product.id),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quantityButton(
      {required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16, color: const Color(0xFF2C3E50)),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2)),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Toplam',
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text(
                '₺${_cart.totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF2C3E50)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        '🎉 Sipariş simülasyonu tamamlandı! (Demo)'),
                    backgroundColor: Color(0xFF27AE60),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE74C3C),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
              child: const Text(
                'Siparişi Tamamla',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
