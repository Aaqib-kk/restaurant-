import 'package:flutter/material.dart';
import 'package:restaurant_menu/models/menu_item.dart';
import 'package:restaurant_menu/repository/menu_repository.dart';

class MenuViewModel extends ChangeNotifier {
  final MenuRepository _menuRepository = MenuRepository();
  List<MenuItem> _menuItems = [];
  List<MenuItem> _cartItems = [];

  MenuViewModel() {
    fetchMenuItems();
  }

  List<MenuItem> get menuItems => _menuItems;
  List<MenuItem> get cartItems => _cartItems;

  void fetchMenuItems() {
    _menuItems = _menuRepository.fetchMenuItems();
    notifyListeners();
  }

  void addToCart(MenuItem menuItem) {
    _cartItems.add(menuItem);
    notifyListeners();
  }

  void removeFromCart(MenuItem menuItem) {
    _cartItems.remove(menuItem);
    notifyListeners();
  }

  bool isInCart(MenuItem menuItem) {
    return _cartItems.contains(menuItem);
  }
}
