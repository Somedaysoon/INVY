import 'package:flutter/material.dart';

import '../../domain/models/inventory.dart';
import '../../domain/models/inventory_item.dart';
import '../../../../shared/widgets/invy_app_bar.dart';
import '../controllers/inventory_controller.dart';
import '../widgets/item_form_dialog.dart';
import '../widgets/item_tile.dart';

class InventoryDetailScreen extends StatelessWidget {
  const InventoryDetailScreen({
    super.key,
    required this.controller,
    required this.inventoryId,
  });

  final InventoryController controller;
  final String inventoryId;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final inventory = controller.inventories.firstWhere(
          (item) => item.id == inventoryId,
        );

        return Scaffold(
          appBar: InvyAppBar(title: 'INVY', subtitle: inventory.name),
          body: Column(
            children: [
              _InventorySummary(inventory: inventory),
              Expanded(
                child: inventory.items.isEmpty
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Text(
                            'No items yet.\nTap + to add inventory items.',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 88),
                        itemCount: inventory.items.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final item = inventory.items[index];

                          return ItemTile(
                            item: item,
                            onEdit: () => _openItemForm(
                              context,
                              inventory: inventory,
                              existingItem: item,
                            ),
                            onDelete: () {
                              controller.deleteItem(
                                inventoryId: inventory.id,
                                itemId: item.id,
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _openItemForm(context, inventory: inventory),
            tooltip: 'Add item',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  Future<void> _openItemForm(
    BuildContext context, {
    required Inventory inventory,
    InventoryItem? existingItem,
  }) async {
    final result = await showDialog<ItemFormResult>(
      context: context,
      builder: (_) => ItemFormDialog(existingItem: existingItem),
    );

    if (result == null) {
      return;
    }

    if (existingItem == null) {
      controller.addItem(
        inventoryId: inventory.id,
        name: result.name,
        quantity: result.quantity,
      );
      return;
    }

    controller.updateItem(
      inventoryId: inventory.id,
      itemId: existingItem.id,
      name: result.name,
      quantity: result.quantity,
    );
  }
}

class _InventorySummary extends StatelessWidget {
  const _InventorySummary({required this.inventory});

  final Inventory inventory;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(inventory.name, style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            'Total items: ${inventory.totalItems}',
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 4),
          Text(
            'Low stock items: ${inventory.lowStockCount}',
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
