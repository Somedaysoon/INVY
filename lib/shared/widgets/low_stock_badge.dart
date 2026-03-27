import 'package:flutter/material.dart';

class LowStockBadge extends StatelessWidget {
  const LowStockBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF7E4C7),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        'Low stock',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: const Color(0xFF8A5A14),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
