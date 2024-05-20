import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_menu/viewmodel/admin_view_model.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminLoginPage extends StatefulWidget {
  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('admin_token');
    if (token != null) {
      Navigator.pushReplacementNamed(context, '/admin-menu-management');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.w),
        child: Consumer<AdminViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                SizedBox(height: 2.h),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 2.h),
                viewModel.isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          bool success = await viewModel.loginAdmin(
                            emailController.text,
                            passwordController.text,
                          );
                          if (success) {
                            Navigator.pushReplacementNamed(context, '/admin-menu-management');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(viewModel.errorMessage ?? 'Login failed')),
                            );
                          }
                        },
                        child: Text('Login'),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
