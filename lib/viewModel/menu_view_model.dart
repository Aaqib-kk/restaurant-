import 'package:flutter/material.dart';
import 'package:restaurant_menu/models/menu_item.dart';
import 'package:restaurant_menu/repository/menu_repo.dart';

class MenuViewModel extends ChangeNotifier {
  final MenuRepository _menuRepository = MenuRepository();
  List<MenuItem> _menuItems = [];
  Map<MenuItem, int> _cartItems = {};

  MenuViewModel() {
    fetchMenuItems();
  }

  List<MenuItem> get menuItems => _menuItems;
  List<MapEntry<MenuItem, int>> get cartItems => _cartItems.entries.toList();

  Future<void> fetchMenuItems() async {
    try {
      _menuItems = await _menuRepository.getMenu();
    } catch (e) {
      _menuItems = []; // If there's an error, set menu items to an empty list
    }
    notifyListeners();
  }

  void addToCart(MenuItem menuItem) {
    if (_cartItems.containsKey(menuItem)) {
      _cartItems[menuItem] = _cartItems[menuItem]! + 1;
    } else {
      _cartItems[menuItem] = 1;
    }
    notifyListeners();
  }

  void removeFromCart(MenuItem menuItem) {
    if (_cartItems.containsKey(menuItem) && _cartItems[menuItem]! > 0) {
      _cartItems[menuItem] = _cartItems[menuItem]! - 1;
      if (_cartItems[menuItem] == 0) {
        _cartItems.remove(menuItem);
      }
    }
    notifyListeners();
  }

  bool isInCart(MenuItem menuItem) {
    return _cartItems.containsKey(menuItem);
  }

  int getCartQuantity(MenuItem menuItem) {
    return _cartItems[menuItem] ?? 0;
  }
}
