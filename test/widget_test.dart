import 'package:apps/features/inventory/data/inventory_repository.dart';
import 'package:apps/features/inventory/presentation/controllers/inventory_controller.dart';
import 'package:apps/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows seeded inventories on the home screen', (tester) async {
    final controller = InventoryController(repository: InventoryRepository())
      ..loadInventories();

    await tester.pumpWidget(InventoryApp(controller: controller));

    expect(find.text('INVY'), findsOneWidget);
    expect(find.text('Grocery Store'), findsOneWidget);
    expect(find.text('Warehouse'), findsOneWidget);
  });
}
