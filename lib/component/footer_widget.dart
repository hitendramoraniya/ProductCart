import 'package:flutter/material.dart';
import 'package:tech_task/notifier/category_notifier.dart';
import 'package:tech_task/res/app_color.dart';
import 'package:tech_task/res/app_string.dart';
import 'package:tech_task/utils/utility.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          height: 0.02,
          color: AppColors.lightGreyColor2,
        ),
        Padding(
          padding:
              const EdgeInsets.only(bottom: 10, left: 15, right: 15, top: 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                AppString.instance.copyrightNotice,
                style: const TextStyle(
                    fontSize: 12, color: AppColors.textColorBlack),
              ),
              const Spacer(),
              ValueListenableBuilder(
                  valueListenable: categoryNotifier.cartProductList,
                  builder: (context, cartProductList, child) {
                    return cartProductList.data != null &&
                            cartProductList.data.length > 0
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${cartProductList.data.length} ${AppString.instance.items}",
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textColorBlack),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "${AppString.instance.total} : ${getTotalAmount(cartProductList.data)} ${AppString.instance.currencySymbol}",
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textColorBlack),
                              ),
                            ],
                          )
                        : const SizedBox();
                  }),
            ],
          ),
        ),
      ],
    );
  }
}
