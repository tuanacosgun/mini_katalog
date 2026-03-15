// lib/main.dart

import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';

void main() {
  runApp(const MiniKatalogApp());
}

class MiniKatalogApp extends StatelessWidget {
  const MiniKatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Katalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Tema renkleri
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2C3E50),
          brightness: Brightness.light,
        ),
        // AppBar teması
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2C3E50),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        // Scaffold arka plan
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        // Yükleme göstergesi rengi
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color(0xFF2C3E50),
        ),
        useMaterial3: true,
      ),

      // Named Routes tanımları (Navigasyon)
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/cart': (context) => const CartScreen(),
      },

      // Route bulunamazsa fallback
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Sayfa Bulunamadı')),
            body: const Center(child: Text('404 - Sayfa mevcut değil')),
          ),
        );
      },
    );
  }
}
