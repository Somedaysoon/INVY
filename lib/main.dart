import 'package:flutter/material.dart';

import 'features/inventory/data/inventory_repository.dart';
import 'features/inventory/presentation/controllers/inventory_controller.dart';
import 'features/inventory/presentation/screens/inventory_list_screen.dart';

void main() {
  final repository = InventoryRepository();
  final controller = InventoryController(repository: repository)
    ..loadInventories();

  runApp(InventoryApp(controller: controller));
}

class InventoryApp extends StatelessWidget {
  const InventoryApp({super.key, required this.controller});

  final InventoryController controller;

  @override
  Widget build(BuildContext context) {
    const surfaceTint = Color(0xFF4C7C7D);
    const background = Color(0xFFF4F7F8);
    const foreground = Color(0xFF233238);

    return MaterialApp(
      title: 'INVY',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(
              seedColor: surfaceTint,
              brightness: Brightness.light,
            ).copyWith(
              surface: Colors.white,
              surfaceContainerHighest: const Color(0xFFE4ECEC),
              onSurface: foreground,
            ),
        scaffoldBackgroundColor: background,
        appBarTheme: const AppBarTheme(
          backgroundColor: background,
          foregroundColor: foreground,
          elevation: 0,
          centerTitle: true,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 2,
          shadowColor: Colors.black.withValues(alpha: 0.06),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          margin: EdgeInsets.zero,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: foreground,
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: foreground,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: foreground,
          ),
          bodyLarge: TextStyle(fontSize: 15, height: 1.4, color: foreground),
          bodyMedium: TextStyle(
            fontSize: 14,
            height: 1.4,
            color: Color(0xFF56656A),
          ),
        ),
        useMaterial3: true,
      ),
      home: InventoryListScreen(controller: controller),
    );
  }
}
