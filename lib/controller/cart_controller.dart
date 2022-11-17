import 'package:flutter/foundation.dart';
import '../model/cart_item.dart';

class CartController with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  
  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartitem) {
      total += cartitem.price * cartitem.quantity;
    });
    return total;
  }

  void addItem({required String productId, required double price, required String title, required String image}) {
    if (_items.containsKey(productId)) {
      //change quantity
      _items.update(
          productId,
          (existing) => CartItem(
              id: existing.id,
              title: existing.title,
              quantity: existing.quantity + 1,
              price: existing.price,
              img: image
            ));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price,
              img: image
            ));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId); // _items.remove(key)
    notifyListeners();
  }

  void clear() {
    //to clear cart items once the order is placed
    _items = {};
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    // for undo button while adding to cart
    if (!_items.containsKey(productId)) return;
    if (_items[productId]!.quantity > 1) {
      _items.update(
          productId,
          (value) => CartItem(
              id: value.id,
              title: value.title,
              quantity: value.quantity - 1,
              price: value.price,
              img: value.img
            ));
    } else {
      //if quantity == 1
      _items.remove(productId);
    }
    notifyListeners();
  }
}