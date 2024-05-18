import 'package:restaurant_menu/models/menu_item.dart';

class MenuRepository {
  List<MenuItem> fetchMenuItems() {
    return [
      MenuItem(name: 'Burger', description: 'Delicious beef burger', price: 5.99),
      MenuItem(name: 'Pizza', description: 'Cheesy pizza with toppings', price: 8.99),
      MenuItem(name: 'Pasta', description: 'Italian pasta with sauce', price: 7.99),
      MenuItem(name: 'Salad', description: 'Fresh garden salad', price: 4.99),
      MenuItem(name: 'Soup', description: 'Hot vegetable soup', price: 3.99),
      MenuItem(name: 'Steak', description: 'Juicy grilled steak', price: 12.99),
      MenuItem(name: 'Sandwich', description: 'Tasty ham sandwich', price: 5.49),
      MenuItem(name: 'Fries', description: 'Crispy french fries', price: 2.99),
      MenuItem(name: 'Ice Cream', description: 'Creamy ice cream', price: 3.49),
      MenuItem(name: 'Cake', description: 'Chocolate cake', price: 4.49),
      MenuItem(name: 'Coffee', description: 'Hot brewed coffee', price: 1.99),
      MenuItem(name: 'Tea', description: 'Refreshing tea', price: 1.49),
    ];
  }
}
