// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/mock_data.dart';
import '../widgets/product_card.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/category_filter.dart';
import 'cart_screen.dart';
import '../models/cart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Cart _cart = Cart();

  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  List<String> _categories = [];
  String _selectedCategory = 'Tümü';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    // Mock veri yükleme (JSON simülasyonu)
    _allProducts = getMockProducts();
    _categories = getCategories();
    _filteredProducts = _allProducts;
  }

  // Arama ve filtreleme mantığı
  void _filterProducts() {
    setState(() {
      _filteredProducts = _allProducts.where((product) {
        final matchesSearch = _searchQuery.isEmpty ||
            product.title
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            product.category
                .toLowerCase()
                .contains(_searchQuery.toLowerCase());

        final matchesCategory = _selectedCategory == 'Tümü' ||
            product.category == _selectedCategory;

        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  void _onSearchChanged(String query) {
    _searchQuery = query;
    _filterProducts();
  }

  void _onCategorySelected(String category) {
    _selectedCategory = category;
    _filterProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C3E50),
        elevation: 0,
        title: const Text(
          '🛍 Mini Katalog',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 20,
            letterSpacing: 0.5,
          ),
        ),
        actions: [
          // Sepet butonu
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartScreen()),
                ).then((_) => setState(() {}));
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.shopping_cart_outlined,
                      color: Colors.white, size: 26),
                  if (_cart.itemCount > 0)
                    Positioned(
                      top: 6,
                      right: 0,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            _cart.itemCount.toString(),
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Üst bölge - Arama + Filtre
          Container(
            color: const Color(0xFF2C3E50),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBarWidget(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                ),
                const SizedBox(height: 14),
                CategoryFilter(
                  categories: _categories,
                  selectedCategory: _selectedCategory,
                  onCategorySelected: _onCategorySelected,
                ),
              ],
            ),
          ),
          // Ürün Sayısı
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Text(
                  '${_filteredProducts.length} ürün bulundu',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF7F8C8D),
                  ),
                ),
              ],
            ),
          ),
          // Ürün Grid'i
          Expanded(
            child: _filteredProducts.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search_off,
                            size: 60, color: Colors.grey),
                        SizedBox(height: 12),
                        Text(
                          'Ürün bulunamadı',
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.68,
                    ),
                    itemCount: _filteredProducts.length,
                    itemBuilder: (_, index) {
                      return ProductCard(
                          product: _filteredProducts[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
