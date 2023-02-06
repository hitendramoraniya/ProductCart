import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tech_task/models/slider_image_model.dart';
import 'package:tech_task/notifier/category_notifier.dart';
import 'package:tech_task/res/app_color.dart';
import 'package:tech_task/utils/constants.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        width: Constants.width,
        child: ValueListenableBuilder(
            valueListenable: categoryNotifier.sliderImageList,
            builder: (context, sliderImageList, child) {
              return PageView.builder(
                  itemCount: sliderImageList.data.length,
                  pageSnapping: true,
                  itemBuilder: (context, pagePosition) {
                    return CachedNetworkImage(
                      imageUrl: (sliderImageList
                              .data![pagePosition] as SliderImageModel)
                          .downloadUrl!,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        color: AppColors.lightGreyColor,
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        size: 30,
                      ),
                    );
                  });
            }));
  }
}
