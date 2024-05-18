import 'package:restaurant_menu/models/menu_item.dart';

class MenuRepository {
  List<MenuItem> fetchMenuItems() {
    return [
      MenuItem(
        name: 'Burger',
        description: 'Delicious beef burger',
        price: 5.99,
        imageUrl: 'https://dummyimage.com/300x200/000/fff',
      ),
      MenuItem(
        name: 'Pizza',
        description: 'Cheesy pizza with toppings',
        price: 8.99,
        imageUrl: 'https://dummyimage.com/400x300/00ff00/000',
      ),
      MenuItem(
        name: 'Pasta',
        description: 'Italian pasta with sauce',
        price: 7.99,
        imageUrl: 'https://dummyimage.com/600x400/0000ff/fff',
      ),
      MenuItem(
        name: 'Salad',
        description: 'Fresh garden salad',
        price: 4.99,
        imageUrl: 'https://dummyimage.com/800x600/ff0000/fff',
      ),
      MenuItem(
        name: 'Soup',
        description: 'Hot vegetable soup',
        price: 3.99,
        imageUrl: 'https://dummyimage.com/200x200/ff00ff/fff',
      ),
      MenuItem(
        name: 'Steak',
        description: 'Juicy grilled steak',
        price: 12.99,
        imageUrl: 'https://dummyimage.com/500x300/ffff00/000',
      ),
      MenuItem(
        name: 'Sandwich',
        description: 'Tasty ham sandwich',
        price: 5.49,
        imageUrl: 'https://dummyimage.com/700x500/ff6600/fff',
      ),
      MenuItem(
        name: 'Fries',
        description: 'Crispy french fries',
        price: 2.99,
        imageUrl: 'https://dummyimage.com/900x700/663399/fff',
      ),
      MenuItem(
        name: 'Ice Cream',
        description: 'Creamy ice cream',
        price: 3.49,
        imageUrl: 'https://dummyimage.com/250x150/9966cc/fff',
      ),
      MenuItem(
        name: 'Cake',
        description: 'Chocolate cake',
        price: 4.49,
        imageUrl: 'https://dummyimage.com/450x350/00cccc/000',
      ),
      MenuItem(
        name: 'Coffee',
        description: 'Hot brewed coffee',
        price: 1.99,
        imageUrl: 'https://dummyimage.com/650x450/cc00cc/fff',
      ),
      MenuItem(
        name: 'Tea',
        description: 'Refreshing tea',
        price: 1.49,
        imageUrl: 'https://dummyimage.com/850x650/339966/fff',
      ),
      MenuItem(
        name: 'Muffin',
        description: 'Tasty muffin',
        price: 2.99,
        imageUrl: 'https://dummyimage.com/150x100/ff9933/000',
      ),
      MenuItem(
        name: 'Waffles',
        description: 'Delicious waffles',
        price: 6.99,
        imageUrl: 'https://dummyimage.com/350x250/33cc99/fff',
      ),
      MenuItem(
        name: 'Pancakes',
        description: 'Fluffy pancakes',
        price: 4.99,
        imageUrl: 'https://dummyimage.com/550x350/3399ff/000',
      ),
      MenuItem(
        name: 'Bacon',
        description: 'Crispy bacon',
        price: 3.49,
        imageUrl: 'https://dummyimage.com/750x550/996633/fff',
      ),
      MenuItem(
        name: 'Omelette',
        description: 'Cheese omelette',
        price: 5.99,
        imageUrl: 'https://dummyimage.com/950x750/cc9966/fff',
      ),
      MenuItem(
        name: 'Smoothie',
        description: 'Fruit smoothie',
        price: 4.49,
        imageUrl: 'https://dummyimage.com/100x100/6699cc/000',
      ),
      MenuItem(
        name: 'Milkshake',
        description: 'Chocolate milkshake',
        price: 4.99,
        imageUrl: 'https://dummyimage.com/300x250/663366/fff',
      ),
      MenuItem(
        name: 'Latte',
        description: 'Hot latte',
        price: 3.99,
        imageUrl: 'https://dummyimage.com/500x400/ff6699/000',
      ),
    ];
  }
}
