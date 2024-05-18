import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_menu/models/menu_item.dart';
import 'package:restaurant_menu/viewmodel/menu_view_model.dart';

class MenuItemDetailDialog extends StatelessWidget {
  final MenuItem menuItem;

  MenuItemDetailDialog({required this.menuItem});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Consumer<MenuViewModel>(
        builder: (context, viewModel, child) {
          int quantity = viewModel.getCartQuantity(menuItem);

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        menuItem.imageUrl,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    menuItem.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Rs. ${menuItem.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 8),
                  Text(
                    menuItem.description,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
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
                      Text('$quantity', style: TextStyle(fontSize: 18)),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          viewModel.addToCart(menuItem);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: quantity > 0
                          ? () {
                              viewModel.addToCart(menuItem);
                              Navigator.of(context).pop();
                            }
                          : null,
                      child: Text('Add to Cart'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
