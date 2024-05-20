class AppUrl {
  //home ip address
  static var baseUrl = "http://192.168.0.106:3003/api/menu";
  //live server
  // static var baseUrl =
  //     "https://backend-restaurent.softsolutioners.com/api/menu";

  // static var adminLogin =
  //     "https://backend-restaurent.softsolutioners.com/api/admin/login";
  static var adminLogin = "http://192.168.0.106:3003/api/admin/login";
  static var createMenu = "http://192.168.0.106:3003/api/menu/createMenu";
  static var updateMenu = "http://192.168.0.106:3003/api/admin";
  static var deleteMenu = "http://192.168.0.106:3003/api/menu/menu";
  static var uploadImage = "http://192.168.0.106:3003/api/menu/uploadImage";

  static var getMenu = "$baseUrl/menu";
  // static var signup = "$baseUrl/signup";
  // static var userInformation = "$baseUrl/getUserInformation";
  // static var changePassword = "$baseUrl/changePassword";
}
