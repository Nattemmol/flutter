import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/providers/shopping_list_provider.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ShoppingListProvider shoppingList = Get.put(ShoppingListProvider());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
        backgroundColor: const Color(0xFF667eea),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Clear All',
            onPressed: () => shoppingList.clear(),
          ),
        ],
      ),
      body: Obx(() {
        final items = shoppingList.items;
        if (items.isEmpty) {
          return const Center(child: Text('Your shopping list is empty.'));
        }
        return ListView.separated(
          itemCount: items.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              leading: Checkbox(
                value: item['checked'] ?? false,
                onChanged: (_) => shoppingList.toggleItem(item['name']),
              ),
              title: Text(item['name']),
              trailing: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => shoppingList.removeItem(item['name']),
              ),
            );
          },
        );
      }),
    );
  }
}
