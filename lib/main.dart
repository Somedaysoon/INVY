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
    const primary = Color(0xFF1F3A5F);
    const secondary = Color(0xFF2E6F95);
    const background = Color(0xFFF4F7FB);
    const foreground = Color(0xFF1F2937);

    return MaterialApp(
      title: 'INVY',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(
              seedColor: primary,
              brightness: Brightness.light,
            ).copyWith(
              primary: primary,
              secondary: secondary,
              surface: Colors.white,
              surfaceContainerHighest: const Color(0xFFE5ECF5),
              onPrimary: Colors.white,
              onSurface: foreground,
              error: const Color(0xFFD14B4B),
            ),
        scaffoldBackgroundColor: background,
        appBarTheme: const AppBarTheme(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 1.5,
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
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: secondary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: secondary,
          foregroundColor: Colors.white,
          elevation: 4,
        ),
        dialogTheme: DialogThemeData(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
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
