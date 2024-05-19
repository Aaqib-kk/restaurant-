import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_menu/models/menu_item.dart';
import 'package:restaurant_menu/viewmodel/menu_view_model.dart';
import 'package:sizer/sizer.dart';

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
              padding: EdgeInsets.all(3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.close, size: 6.w),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        menuItem.imageUrl ?? '',
                        height: 30.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    menuItem.name ?? '',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'Rs. ${menuItem.price?.toStringAsFixed(2) ?? 'N/A'}',
                    style: TextStyle(fontSize: 18.sp, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    menuItem.description ?? '',
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    menuItem.category ?? '',
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, size: 6.w),
                        onPressed: quantity > 0
                            ? () {
                                viewModel.removeFromCart(menuItem);
                              }
                            : null,
                      ),
                      Text('$quantity', style: TextStyle(fontSize: 18.sp)),
                      IconButton(
                        icon: Icon(Icons.add, size: 6.w),
                        onPressed: () {
                          viewModel.addToCart(menuItem);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Center(
                    child: ElevatedButton(
                      onPressed: quantity > 0
                          ? () {
                              viewModel.addToCart(menuItem);
                              Navigator.of(context).pop();
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: quantity > 0
                            ? Theme.of(context).cardColor
                            : Colors.grey,
                      ),
                      child: Text('Add to Cart',
                          style: TextStyle(fontSize: 14.sp)),
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
