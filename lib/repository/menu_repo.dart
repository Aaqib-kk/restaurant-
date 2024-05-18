import 'dart:convert';
import 'package:restaurant_menu/models/menu_item.dart';
import 'package:restaurant_menu/service/base_api_service.dart';
import 'package:restaurant_menu/service/network_api_service.dart';
import 'package:restaurant_menu/widgets/app_url.dart';

class MenuRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<List<MenuItem>> getMenu() async {
    try {
      final response = await _apiServices.get(AppUrl.getMenu, headers: {});
      List<dynamic> jsonResponse = jsonDecode(response);
      List<MenuItem> menuItems = jsonResponse.map((item) => MenuItem.fromJson(item)).toList();
      return menuItems;
    } catch (e) {
      // Handle or throw exceptions as needed
      rethrow;
    }
  }
}
