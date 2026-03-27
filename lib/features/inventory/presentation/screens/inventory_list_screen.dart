import 'package:flutter/material.dart';

import '../controllers/inventory_controller.dart';
import '../widgets/inventory_card.dart';
import '../widgets/inventory_form_dialog.dart';
import '../../../../shared/widgets/invy_app_bar.dart';
import 'inventory_detail_screen.dart';

class InventoryListScreen extends StatelessWidget {
  const InventoryListScreen({super.key, required this.controller});

  final InventoryController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final inventories = controller.inventories;

        return Scaffold(
          appBar: const InvyAppBar(
            title: 'INVY',
            subtitle: 'Manage your inventories with clarity',
          ),
          body: inventories.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Text(
                      'No inventories found yet.\nTap + to create your first inventory.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 88),
                  itemCount: inventories.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final inventory = inventories[index];

                    return InventoryCard(
                      inventory: inventory,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => InventoryDetailScreen(
                              controller: controller,
                              inventoryId: inventory.id,
                            ),
                          ),
                        );
                      },
                      onDelete: () =>
                          controller.deleteInventory(inventoryId: inventory.id),
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _openAddInventoryDialog(context),
            tooltip: 'Add inventory',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  Future<void> _openAddInventoryDialog(BuildContext context) async {
    final inventoryName = await showDialog<String>(
      context: context,
      builder: (_) => const InventoryFormDialog(),
    );

    if (inventoryName == null || inventoryName.isEmpty) {
      return;
    }

    // Keep inventory creation simple by delegating straight to the controller.
    controller.addInventory(name: inventoryName);
  }
}
