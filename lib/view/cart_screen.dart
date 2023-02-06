import 'package:flutter/material.dart';
import 'package:tech_task/component/footer_widget.dart';
import 'package:tech_task/component/header_widget.dart';
import 'package:tech_task/data/remote/response/status.dart';
import 'package:tech_task/models/product_model.dart';
import 'package:tech_task/notifier/category_notifier.dart';
import 'package:tech_task/res/app_color.dart';
import 'package:tech_task/res/app_string.dart';
import 'package:tech_task/utils/constants.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      categoryNotifier.fetchCartProductListFromSF();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        color: AppColors.backColor,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            HeaderWidget(
              title: AppString.instance.cart,
              isShowCartIcon: false,
              isShowClearCartIcon: true,
            ),
            CartWidget(),
            const FooterWidget(),
          ],
        ),
      ),
    ));
  }

  Widget CartWidget() {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: categoryNotifier.cartProductList,
        builder: (context, cartProductList, child) {
          switch (cartProductList.status) {
            case Status.LOADING:
              return SizedBox(
                height: Constants.height,
                child: const Center(
                    child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                )),
              );
            case Status.ERROR:
              return Center(child: Text(cartProductList.message!));
            case Status.COMPLETED:
              return Builder(builder: (context) {
                return (cartProductList.data as List<ProductModel>).isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.shopping_cart_outlined,
                              color: AppColors.greyColor,
                              size: 100,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              AppString.instance.cartIsEmpty,
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: AppColors.textColorBlack),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(10.0),
                        itemBuilder: (context, index) =>
                            CartItemWidget(cartProductList.data[index], index),
                        itemCount:
                            (cartProductList.data as List<ProductModel>).length,
                      );
              });
            default:
              return Center(child: Text(AppString.instance.somethingWentWrong));
          }
        },
      ),
    );
  }

  Widget CartItemWidget(ProductModel productModel, int index) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        color: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 50,
                  width: 50,
                  child: Image.network(
                    productModel.image!,
                    fit: BoxFit.contain,
                  )),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 7.0, left: 7, right: 7),
                      child: Text(
                        productModel.title!,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        style: const TextStyle(
                            fontSize: 14, color: AppColors.textColorBlack),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 7.0, left: 7, right: 7),
                      child: Text(
                        "${AppString.instance.currencySymbol} ${productModel.price!.toInt()}",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.redColor,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  categoryNotifier.deleteSingleCartProductFromSF(index);
                },
                child: Card(
                  color: AppColors.whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.3,
                            // assign the color to the border color
                            color: AppColors.greyColor,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50))),
                      child: const Icon(
                        Icons.remove,
                        color: AppColors.blackColor,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
