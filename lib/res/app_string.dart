class AppString {
  static AppString instance = AppString._init();

  AppString._init();

  final String appName = "Product Cart";
  final String category = "Category";
  final String product = "Product";
  final String cart = "Cart";
  final String profile = "Profile";
  final String somethingWentWrong = "Something went wrong";
  final String itemAdded = "Item added successfully";
  final String addToCart = "Add to Cart";
  final String removeItem = "Remove Item";
  final String itemRemoved = "Item removed successfully";
  final String copyrightNotice = "Copyright";
  final String currencySymbol = "Rs";
  final String noRouteDefined = "No route defined";
  final String items = "Items";
  final String cartIsEmpty = "Cart is Empty";
  final String total = "Total";

  // Images
  final String iconFlutter = "assets/images/icon_flutter.jpg";

  // Preferences key
  final String cartList = "cartList";

  // Exception
  final String errorDuringCommunication = "Error During Communication";
  final String invalidRequest = "Invalid request";
  final String unauthorisedRequest = "Unauthorised request";
  final String unauthorisedInput = "Unauthorised Input";
  final String noInternetConnection = "No Internet Connection";
  final String fetchDataException =
      "Error accorded while communicating with server with status code";
}
