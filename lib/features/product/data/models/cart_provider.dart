import 'package:easy_shop/features/product/data/models/product_model.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final Map<int, int> _itemQuantities = {};
  final List<Product> _items = [];

  List<Product> get items => _items;

  int getQuantity(int productId) => _itemQuantities[productId] ?? 1;

  void addToCart(Product product) {
    if (!_items.any((item) => item.id == product.id)) {
      _items.add(product);
      _itemQuantities[product.id] = 1;
    }
    notifyListeners();
  }

  void removeFromCart(int id) {
    _items.removeWhere((item) => item.id == id);
    _itemQuantities.remove(id);
    notifyListeners();
  }

  void incrementQuantity(int productId) {
    _itemQuantities[productId] = (getQuantity(productId) + 1);
    notifyListeners();
  }

  void decrementQuantity(int productId) {
    if (getQuantity(productId) > 1) {
      _itemQuantities[productId] = (getQuantity(productId) - 1);
      notifyListeners();
    }
  }

  double get total {
    return _items.fold<double>(
      0,
      (sum, item) => sum + (item.price * getQuantity(item.id)),
    );
  }
}
