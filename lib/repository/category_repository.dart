import 'package:tech_task/data/remote/network/network_api_services.dart';
import 'package:tech_task/models/slider_image_model.dart';
import 'package:tech_task/res/app_url.dart';

class CategoryRepository {

  Future<List<String>> getAllCategory() async {
    try {
      dynamic response =
          await apiServices.getGetApiResponse(AppUrl.getAllCategories);
      return List.from(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<SliderImageModel>> getSliderImages() async {
    try {
      dynamic response =
          await apiServices.getGetApiResponse(AppUrl.getSliderImageList);
      return List<SliderImageModel>.from(
          response.map((x) => SliderImageModel.fromJson(x)));
    } catch (e) {
      rethrow;
    }
  }
}
