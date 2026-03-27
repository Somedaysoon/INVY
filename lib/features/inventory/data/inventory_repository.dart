import '../domain/models/inventory.dart';
import '../domain/models/inventory_item.dart';

class InventoryRepository {
  final List<Inventory> _inventories = [
    const Inventory(
      id: 'inv_grocery',
      name: 'Grocery Store',
      items: [
        InventoryItem(id: 'item_rice', name: 'Rice Bag', quantity: 12),
        InventoryItem(id: 'item_milk', name: 'Milk Carton', quantity: 4),
        InventoryItem(id: 'item_apples', name: 'Apples', quantity: 18),
      ],
    ),
    const Inventory(
      id: 'inv_warehouse',
      name: 'Warehouse',
      items: [
        InventoryItem(id: 'item_boxes', name: 'Packing Boxes', quantity: 40),
        InventoryItem(id: 'item_tape', name: 'Packing Tape', quantity: 3),
      ],
    ),
  ];

  // This acts like a local data source for now.
  // Later you can replace it with shared preferences, Hive, or SQLite.
  List<Inventory> loadInventories() {
    return _inventories
        .map(
          (inventory) => inventory.copyWith(
            items: List<InventoryItem>.from(inventory.items),
          ),
        )
        .toList();
  }

  List<Inventory> saveInventories(List<Inventory> inventories) {
    _inventories
      ..clear()
      ..addAll(inventories);

    return loadInventories();
  }
}
