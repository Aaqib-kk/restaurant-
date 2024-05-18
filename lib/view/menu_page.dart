import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_menu/models/menu_item.dart';
import '../ViewModel/menu_view_model.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MenuViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Menu'),
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
        bool isInCart = viewModel.isInCart(menuItem);

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
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
            isInCart
                ? TextButton(
                    onPressed: () {
                      viewModel.removeFromCart(menuItem);
                      Navigator.of(context).pop();
                    },
                    child: Text('Remove from Cart'),
                  )
                : ElevatedButton(
                    onPressed: () {
                      viewModel.addToCart(menuItem);
                      Navigator.of(context).pop();
                    },
                    child: Text('Add to Cart'),
                  ),
          ],
        );
      },
    );
  }
}
