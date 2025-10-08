import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ShoppingListProvider extends GetxController {
  final _storage = GetStorage();
  final RxList<Map<String, dynamic>> _items = <Map<String, dynamic>>[].obs;

  List<Map<String, dynamic>> get items => _items;

  @override
  void onInit() {
    super.onInit();
    final stored = _storage.read('shoppingList') as List?;
    if (stored != null) {
      _items.value = List<Map<String, dynamic>>.from(stored);
    }
  }

  void addItem(String name) {
    if (!_items.any((item) => item['name'] == name)) {
      _items.add({'name': name, 'checked': false});
      _save();
    }
  }

  void removeItem(String name) {
    _items.removeWhere((item) => item['name'] == name);
    _save();
  }

  void toggleItem(String name) {
    final idx = _items.indexWhere((item) => item['name'] == name);
    if (idx != -1) {
      _items[idx]['checked'] = !_items[idx]['checked'];
      _save();
    }
  }

  void clear() {
    _items.clear();
    _save();
  }

  void addItems(List<String> names) {
    for (final name in names) {
      addItem(name);
    }
  }

  void _save() {
    _storage.write('shoppingList', _items);
  }
}
