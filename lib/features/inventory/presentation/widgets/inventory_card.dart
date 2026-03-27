import 'package:flutter/material.dart';

import '../../domain/models/inventory.dart';

class InventoryCard extends StatelessWidget {
  const InventoryCard({
    super.key,
    required this.inventory,
    required this.onTap,
    required this.onDelete,
  });

  final Inventory inventory;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 1.5,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(inventory.name, style: theme.textTheme.titleMedium),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${inventory.totalItems} items',
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 4),
              Text(
                '${inventory.lowStockCount} low stock',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: 'Delete inventory',
              onPressed: onDelete,
              icon: Icon(Icons.delete_outline, color: theme.colorScheme.error),
            ),
            Icon(Icons.chevron_right, color: theme.colorScheme.primary),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
