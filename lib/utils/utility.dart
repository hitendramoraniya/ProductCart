import 'package:tech_task/models/product_model.dart';

int getTotalAmount(List<ProductModel> cartProductList) {
  return cartProductList
      .map((expense) => expense.price)
      .fold(0, (prev, amount) => prev + amount!.toInt());
}

String capitalizeOnlyFirstLater(String str) {
  if (str.trim().isEmpty) return "";
  return "${str[0].toUpperCase()}${str.substring(1)}";
}
