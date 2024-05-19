import 'package:flutter/material.dart';
import 'package:restaurant_menu/repository/admin_repo.dart';

class AdminViewModel extends ChangeNotifier {
  final AdminRepository _adminRepository = AdminRepository();
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> loginAdmin(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    bool success = await _adminRepository.loginAdmin({
      "email": email,
      "password": password,
    });

    _isLoading = false;
    if (!success) {
      _errorMessage = "Login failed. Please try again.";
    } else {
      _errorMessage = null;
    }
    notifyListeners();

    return success;
  }

  Future<void> logoutAdmin() async {
    await _adminRepository.logoutAdmin();
    notifyListeners();
  }
}
