import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_menu/models/menu_item.dart';
import 'package:restaurant_menu/viewmodel/menu_view_model.dart';
import 'package:sizer/sizer.dart';
import 'create_meal_page.dart';
import 'edit_meal_page.dart';

class AdminMenuManagementPage extends StatefulWidget {
  @override
  _AdminMenuManagementPageState createState() =>
      _AdminMenuManagementPageState();
}

class _AdminMenuManagementPageState extends State<AdminMenuManagementPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<MenuViewModel>(context, listen: false).fetchMenuItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Menu'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to the create meal page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateMealPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await Provider.of<MenuViewModel>(context, listen: false)
                  .logoutAdmin();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
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
              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
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
                          Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                              icon: Icon(Icons.edit,
                                  size: 18.sp, color: Colors.white),
                              onPressed: () {
                                // Navigate to edit meal page with the menu item details
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditMealPage(menuItem: menuItem),
                                  ),
                                );
                              },
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                              icon: Icon(Icons.delete,
                                  size: 18.sp, color: Colors.white),
                              onPressed: () {
                                // Implement delete functionality
                                viewModel.deleteMenuItem(menuItem.sId!);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
