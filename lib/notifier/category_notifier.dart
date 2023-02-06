import 'package:flutter/cupertino.dart';
import 'package:tech_task/data/local/preferences.dart';
import 'package:tech_task/data/remote/response/api_response.dart';
import 'package:tech_task/models/product_model.dart';
import 'package:tech_task/repository/category_repository.dart';
import 'package:tech_task/res/app_string.dart';

CategoryNotifier categoryNotifier = CategoryNotifier(null);

class CategoryNotifier extends ValueNotifier {
  final _categoryRepo = CategoryRepository();

  final ValueNotifier<ApiResponse<dynamic>> _categoryList =
      ValueNotifier(ApiResponse.loading());

  ValueNotifier<ApiResponse<dynamic>> get categoryList => _categoryList;

  final ValueNotifier<ApiResponse<dynamic>> _cartProductList =
      ValueNotifier(ApiResponse.loading());

  ValueNotifier<ApiResponse<dynamic>> get cartProductList => _cartProductList;

  final ValueNotifier<ApiResponse<dynamic>> _sliderImageList =
      ValueNotifier(ApiResponse.loading());

  ValueNotifier<ApiResponse<dynamic>> get sliderImageList => _sliderImageList;

  CategoryNotifier(super.value);

  setSliderImagesList(ApiResponse<dynamic> response) {
    _sliderImageList.value = response;
    notifyListeners();
  }

  setCategoryList(ApiResponse<dynamic> response) {
    _categoryList.value = response;
    notifyListeners();
  }

  Future<void> initCategoryNotifier() async {
    _sliderImageList.value.data = [];
    _cartProductList.value.data = [];
    categoryNotifier.getSliderImageList();
    categoryNotifier.getCategoryListApi();
    await initSharedPreferences();
    await categoryNotifier.fetchCartProductListFromSF();
  }

  Future<void> getSliderImageList() async {
    await _categoryRepo.getSliderImages().then((value) {
      setSliderImagesList(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setSliderImagesList(ApiResponse.error(error.toString())));
  }

  Future<void> getCategoryListApi() async {
    await _categoryRepo.getAllCategory().then((value) {
      setCategoryList(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setCategoryList(ApiResponse.error(error.toString())));
  }

  setCartList(ApiResponse<dynamic> response) {
    _cartProductList.value = response;
    notifyListeners();
  }

  Future<void> fetchCartProductListFromSF() async {
    await readModelFromSF(AppString.instance.cartList).then((value) {
      List<ProductModel> cartProductList;
      if (value != null) {
        cartProductList =
            List<ProductModel>.from(value.map((x) => ProductModel.fromJson(x)));
      } else {
        cartProductList = [];
      }
      setCartList(ApiResponse.completed(cartProductList));
    }).onError((error, stackTrace) =>
        setCartList(ApiResponse.error(error.toString())));
  }

  Future<void> writeCartProductToSF(ProductModel productModel) async {
    await readModelFromSF(AppString.instance.cartList).then((value) async {
      List<ProductModel> cartProductList;
      if (value != null) {
        cartProductList =
            List<ProductModel>.from(value.map((x) => ProductModel.fromJson(x)));
      } else {
        cartProductList = [];
      }
      cartProductList.add(productModel);
      await writeModelToSF(AppString.instance.cartList, cartProductList)
          .then((value) {
        if (value) {
          setCartList(ApiResponse.completed(cartProductList));
        }
      });
    });
  }

  Future<void> deleteCartProductFromSF() async {
    await deleteModelFromSF(AppString.instance.cartList);
    await fetchCartProductListFromSF();
  }

  Future<void> deleteSingleCartProductFromSF(int index) async {
    await readModelFromSF(AppString.instance.cartList).then((value) async {
      List<ProductModel> cartProductList =
          List<ProductModel>.from(value.map((x) => ProductModel.fromJson(x)));
      cartProductList.removeAt(index);
      await writeModelToSF(AppString.instance.cartList, cartProductList)
          .then((value) {
        setCartList(ApiResponse.completed(cartProductList));
      });
    });
  }
}
