import 'package:flutter/foundation.dart';

import '../../domain/models/inventory.dart';
import '../../domain/models/inventory_item.dart';
import '../../data/inventory_repository.dart';

class InventoryController extends ChangeNotifier {
  InventoryController({required InventoryRepository repository})
    : _repository = repository;

  final InventoryRepository _repository;

  List<Inventory> _inventories = [];
  int _inventoryIdCounter = 0;
  int _itemIdCounter = 0;

  List<Inventory> get inventories => List.unmodifiable(_inventories);

  void loadInventories() {
    _inventories = _repository.loadInventories();
    notifyListeners();
  }

  void addInventory({required String name}) {
    final newInventory = Inventory(
      id: 'inventory_${_inventoryIdCounter++}',
      name: name,
      items: const [],
    );

    _inventories = _repository.saveInventories([..._inventories, newInventory]);
    notifyListeners();
  }

  void deleteInventory({required String inventoryId}) {
    _inventories = _repository.saveInventories(
      _inventories.where((inventory) => inventory.id != inventoryId).toList(),
    );
    notifyListeners();
  }

  void addItem({
    required String inventoryId,
    required String name,
    required int quantity,
  }) {
    final newItem = InventoryItem(
      id: 'item_${_itemIdCounter++}',
      name: name,
      quantity: quantity,
    );

    _updateInventory(
      inventoryId: inventoryId,
      update: (inventory) =>
          inventory.copyWith(items: [...inventory.items, newItem]),
    );
  }

  void updateItem({
    required String inventoryId,
    required String itemId,
    required String name,
    required int quantity,
  }) {
    _updateInventory(
      inventoryId: inventoryId,
      update: (inventory) => inventory.copyWith(
        items: inventory.items
            .map(
              (item) => item.id == itemId
                  ? item.copyWith(name: name, quantity: quantity)
                  : item,
            )
            .toList(),
      ),
    );
  }

  void deleteItem({required String inventoryId, required String itemId}) {
    _updateInventory(
      inventoryId: inventoryId,
      update: (inventory) => inventory.copyWith(
        items: inventory.items.where((item) => item.id != itemId).toList(),
      ),
    );
  }

  void _updateInventory({
    required String inventoryId,
    required Inventory Function(Inventory inventory) update,
  }) {
    _inventories = _inventories.map((inventory) {
      if (inventory.id != inventoryId) {
        return inventory;
      }

      return update(inventory);
    }).toList();

    _inventories = _repository.saveInventories(_inventories);
    notifyListeners();
  }
}
