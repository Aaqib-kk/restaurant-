import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_menu/view/menu_item_detail_page.dart';
import 'package:restaurant_menu/viewmodel/menu_view_model.dart';
import 'package:sizer/sizer.dart';
import 'cart_page.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<MenuViewModel>(context, listen: false).fetchMenuItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Text(
            'Restaurant Menu',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: IconButton(
              icon: Icon(Icons.shopping_cart, size: 18.sp),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              },
            ),
          ),
        ],
        toolbarHeight: 15.h,
      ),
      body: Consumer<MenuViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.menuItems.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          return GridView.builder(
            padding: EdgeInsets.all(2.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 2.w,
              mainAxisSpacing: 2.w,
              childAspectRatio: 3 / 2,
            ),
            itemCount: viewModel.menuItems.length,
            itemBuilder: (context, index) {
              final menuItem = viewModel.menuItems[index];
              return InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => MenuItemDetailDialog(menuItem: menuItem),
                  );
                },
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          menuItem.imageUrl ?? '',
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              menuItem.name ?? '',
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              'Rs. ${menuItem.price?.toStringAsFixed(2) ?? 'N/A'}',
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 0.5.h),
                            Expanded(
                              child: Text(
                                menuItem.description ?? '',
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  color: Colors.white,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: 0.5.h),
                            Expanded(
                              child: Text(
                                menuItem.category ?? '',
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
