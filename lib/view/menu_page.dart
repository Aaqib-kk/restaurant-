import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_menu/models/menu_item.dart';
import 'package:restaurant_menu/viewmodel/menu_view_model.dart';
import 'cart_page.dart'; // Import CartPage

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MenuViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Menu'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: viewModel.menuItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(viewModel.menuItems[index].name),
            subtitle: Text('\$${viewModel.menuItems[index].price.toStringAsFixed(2)}'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => MenuItemDetailDialog(menuItem: viewModel.menuItems[index]),
              );
            },
          );
        },
      ),
    );
  }
}

class MenuItemDetailDialog extends StatelessWidget {
  final MenuItem menuItem;

  MenuItemDetailDialog({required this.menuItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuViewModel>(
      builder: (context, viewModel, child) {
        int quantity = viewModel.getCartQuantity(menuItem);

        return AlertDialog(
          title: Text(menuItem.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                menuItem.description,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '\$${menuItem.price.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: quantity > 0
                        ? () {
                            viewModel.removeFromCart(menuItem);
                          }
                        : null,
                  ),
                  Text('$quantity'),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      viewModel.addToCart(menuItem);
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
