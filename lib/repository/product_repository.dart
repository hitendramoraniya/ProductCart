import 'package:tech_task/data/remote/network/network_api_services.dart';
import 'package:tech_task/models/product_model.dart';
import 'package:tech_task/res/app_url.dart';

class ProductRepository {
  Future<List<ProductModel>> getProductList(String categoryName) async {
    try {
      dynamic response = await apiServices
          .getGetApiResponse("${AppUrl.getProductsByCategory}/$categoryName");
      return List<ProductModel>.from(
          response.map((x) => ProductModel.fromJson(x)));
    } catch (e) {
      print("exception$e");
      rethrow;
    }
  }
}
