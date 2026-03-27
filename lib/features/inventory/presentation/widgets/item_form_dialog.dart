import 'package:flutter/material.dart';

import '../../domain/models/inventory_item.dart';

class ItemFormDialog extends StatefulWidget {
  const ItemFormDialog({super.key, this.existingItem});

  final InventoryItem? existingItem;

  @override
  State<ItemFormDialog> createState() => _ItemFormDialogState();
}

class _ItemFormDialogState extends State<ItemFormDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _quantityController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.existingItem?.name ?? '',
    );
    _quantityController = TextEditingController(
      text: widget.existingItem?.quantity.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingItem != null;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      title: Text(isEditing ? 'Edit item' : 'Add item'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Item name'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Enter an item name';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                IconButton(
                  tooltip: 'Decrease quantity',
                  onPressed: () => _changeQuantity(-1),
                  icon: const Icon(Icons.remove_circle_outline),
                  style: IconButton.styleFrom(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _quantityController,
                    decoration: const InputDecoration(labelText: 'Quantity'),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    validator: (value) {
                      final quantity = int.tryParse(value ?? '');
                      if (quantity == null || quantity < 0) {
                        return 'Enter a valid quantity';
                      }
                      return null;
                    },
                  ),
                ),
                IconButton(
                  tooltip: 'Increase quantity',
                  onPressed: () => _changeQuantity(1),
                  icon: const Icon(Icons.add_circle_outline),
                  style: IconButton.styleFrom(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _submit,
          child: Text(isEditing ? 'Save' : 'Add'),
        ),
      ],
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Navigator.of(context).pop(
      ItemFormResult(
        name: _nameController.text.trim(),
        quantity: int.parse(_quantityController.text),
      ),
    );
  }

  void _changeQuantity(int difference) {
    final currentQuantity = int.tryParse(_quantityController.text) ?? 0;
    final updatedQuantity = currentQuantity + difference;

    if (updatedQuantity < 0) {
      return;
    }

    // Updating the text controller keeps manual entry and button taps aligned.
    _quantityController.text = updatedQuantity.toString();
  }
}

class ItemFormResult {
  const ItemFormResult({required this.name, required this.quantity});

  final String name;
  final int quantity;
}
