import 'inventory_item.dart';

class Inventory {
  const Inventory({required this.id, required this.name, required this.items});

  final String id;
  final String name;
  final List<InventoryItem> items;

  int get totalItems => items.length;

  int get lowStockCount => items.where((item) => item.isLowStock).length;

  Inventory copyWith({String? id, String? name, List<InventoryItem>? items}) {
    return Inventory(
      id: id ?? this.id,
      name: name ?? this.name,
      items: items ?? this.items,
    );
  }
}
