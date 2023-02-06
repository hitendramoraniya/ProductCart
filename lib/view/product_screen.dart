import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tech_task/component/footer_widget.dart';
import 'package:tech_task/component/header_widget.dart';
import 'package:tech_task/component/slider_widget.dart';
import 'package:tech_task/data/remote/response/status.dart';
import 'package:tech_task/models/product_model.dart';
import 'package:tech_task/notifier/category_notifier.dart';
import 'package:tech_task/notifier/product_notifier.dart';
import 'package:tech_task/res/app_color.dart';
import 'package:tech_task/res/app_string.dart';
import 'package:tech_task/utils/constants.dart';
import 'package:tech_task/utils/utility.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final categoryName = ModalRoute.of(context)!.settings.arguments as String;
      if (categoryName.isNotEmpty) {
        productNotifier.fetchProductListApi(categoryName);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    productNotifier.clearNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.backColor,
          child: Column(
            children: [
              ValueListenableBuilder(
                  valueListenable: productNotifier.categoryName,
                  builder: (context, categoryName, child) {
                    return HeaderWidget(
                        title: capitalizeOnlyFirstLater(categoryName));
                  }),
              ProductListWidget(),
              const FooterWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget ProductListWidget() {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: productNotifier.productList,
        builder: (context, productList, child) {
          switch (productList.status) {
            case Status.LOADING:
              return SizedBox(
                height: Constants.height,
                child: const Center(
                    child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                )),
              );
            case Status.ERROR:
              return Center(child: Text(productList.message!));
            case Status.COMPLETED:
              return CustomScrollView(
                slivers: <Widget>[
                  const SliverToBoxAdapter(
                    child: SliderWidget(),
                  ),
                  const SliverPadding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 5,
                      childAspectRatio: 0.65,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ProductItemWidget(productList.data[index]);
                      },
                      childCount:
                          (productList.data as List<ProductModel>).length,
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

  Widget ProductItemWidget(ProductModel productModel) {
    return Card(
      color: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0),
      ),
      margin: const EdgeInsets.all(12),
      child: Container(
        alignment: Alignment.center,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 90,
                    width: 90,
                    child: Image.network(
                      productModel.image!,
                      fit: BoxFit.contain,
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 7.0, left: 4, right: 4),
                  child: Text(
                    productModel.title!,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 14, color: AppColors.textColorBlack),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 7.0, left: 4, right: 4),
                  child: Text(
                    "${AppString.instance.currencySymbol} ${productModel.price!.toInt()}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.redColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 7.0, left: 4, right: 4),
                  child: RatingBarIndicator(
                    rating: productModel.rating!.rate!.toDouble(),
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 60,
                  height: 30,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      side: MaterialStateProperty.all<BorderSide>(const BorderSide(
                          width: 0.1, // thickness
                          color: AppColors.blackColor // color
                          )),
                      overlayColor:
                          MaterialStateProperty.all(AppColors.lightGreyColor),
                      elevation: MaterialStateProperty.all<double>(1),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppColors.whiteColor),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    onPressed: () {
                      categoryNotifier.writeCartProductToSF(productModel);
                    },
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
