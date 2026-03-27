class InventoryItem {
  const InventoryItem({
    required this.id,
    required this.name,
    required this.quantity,
  });

  final String id;
  final String name;
  final int quantity;

  // Items at or below this value are shown as low stock.
  bool get isLowStock => quantity <= 5;

  InventoryItem copyWith({String? id, String? name, int? quantity}) {
    return InventoryItem(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
    );
  }
}
