import 'package:flutter/material.dart';
import 'package:tech_task/res/app_string.dart';
import 'package:tech_task/utils/routes_name.dart';
import 'package:tech_task/view/cart_screen.dart';
import 'package:tech_task/view/category_screen.dart';
import 'package:tech_task/view/product_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.category:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CategoryScreen());

      case RoutesName.product:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ProductScreen());

      case RoutesName.cart:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CartScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(child: Text(AppString.instance.noRouteDefined)),
          );
        });
    }
  }
}
