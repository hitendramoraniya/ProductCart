import 'package:flutter/cupertino.dart';
import 'package:tech_task/data/remote/response/api_response.dart';
import 'package:tech_task/repository/product_repository.dart';

ProductNotifier productNotifier = ProductNotifier(null);

class ProductNotifier extends ValueNotifier {
  final _productRepo = ProductRepository();

  final ValueNotifier<ApiResponse<dynamic>> _productList =
      ValueNotifier(ApiResponse.loading());

  ValueNotifier<ApiResponse<dynamic>> get productList => _productList;

  final ValueNotifier<String> _categoryName = ValueNotifier("");

  ValueNotifier<String> get categoryName => _categoryName;

  ProductNotifier(super.value);

  setProductList(ApiResponse<dynamic> response) {
    _productList.value = response;
    notifyListeners();
  }

  Future<void> fetchProductListApi(String categoryName) async {
    _categoryName.value = categoryName;
    _productList.value.data = [];
    await _productRepo.getProductList(categoryName).then((value) {
      setProductList(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setProductList(ApiResponse.error(error.toString())));
  }

  void clearNotifier(){
    productNotifier = ProductNotifier(null);
  }

}
