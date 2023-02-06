import 'package:flutter/material.dart';
import 'package:tech_task/component/footer_widget.dart';
import 'package:tech_task/component/slider_widget.dart';
import 'package:tech_task/data/remote/response/status.dart';
import 'package:tech_task/notifier/category_notifier.dart';
import 'package:tech_task/res/app_color.dart';
import 'package:tech_task/res/app_string.dart';
import 'package:tech_task/utils/constants.dart';
import 'package:tech_task/utils/utility.dart';
import 'package:tech_task/view/product_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    categoryNotifier.initCategoryNotifier();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Constants.height = MediaQuery.of(context).size.height;
    Constants.width = MediaQuery.of(context).size.width;

    return Container(
      color: AppColors.backColor,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          CategoryListWidget(),
          FooterWidget(),
        ],
      ),
    );
  }

  Widget CategoryListWidget() {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: categoryNotifier.categoryList,
        builder: (context, categoryList, child) {
          switch (categoryList.status) {
            case Status.LOADING:
              return SizedBox(
                height: Constants.height,
                child: const Center(
                    child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                )),
              );
            case Status.ERROR:
              return Center(child: Text(categoryList.message!));
            case Status.COMPLETED:
              return CustomScrollView(
                slivers: <Widget>[
                  const SliverToBoxAdapter(
                    child: SliderWidget(),
                  ),
                  const SliverPadding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return CategoryItemWidget(categoryList.data[index]);
                      },
                      childCount: (categoryList.data as List<String>).length,
                    ),
                  ),
                ],
              );
            default:
              return Center(child: Text(AppString.instance.somethingWentWrong));
          }
        },
      ),
    );
  }

  Widget CategoryItemWidget(categoryName) {
    return Card(
      color: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0),
      ),
      margin: EdgeInsets.all(12),
      child: Container(
          alignment: Alignment.center,
          child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductScreen(),
                    settings: RouteSettings(
                      arguments: categoryName,
                    ),
                  ),
                );
              },
              child: Container(
                height: 60,
                child: Center(
                  child: Text(
                    capitalizeOnlyFirstLater(categoryName),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ))),
    );
  }
}
