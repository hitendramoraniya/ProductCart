import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tech_task/notifier/category_notifier.dart';
import 'package:tech_task/res/app_color.dart';
import 'package:tech_task/component/base_alert_dialog.dart';
import 'package:tech_task/view/cart_screen.dart';

class HeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  String title;
  bool isShowCartIcon;
  bool isShowClearCartIcon;

  HeaderWidget({
    super.key,
    required this.title,
    this.isShowCartIcon = true,
    this.isShowClearCartIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: AppColors.whiteColor,
      iconTheme: const IconThemeData(
        color: AppColors.blackColor, //change your color here
      ),
      title: Center(
        child: Text(
          textAlign: TextAlign.center,
          title,
          style: const TextStyle(color: AppColors.textColorBlack),
        ),
      ),
      actions: <Widget>[
        //Profile Pic
        isShowCartIcon
            ? InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: AppColors.blackColor,
                    size: 30,
                  ),
                ),
              )
            : const SizedBox(width: 10,),

        isShowClearCartIcon
            ? ValueListenableBuilder(
                valueListenable: categoryNotifier.cartProductList,
                builder: (context, cartProductList, child) {
                  return cartProductList.data.length > 0
                      ? InkWell(
                          onTap: () {
                            confirmClearCart(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.delete,
                              color: AppColors.primaryColor,
                              size: 25,
                            ),
                          ),
                        )
                      : const SizedBox(
                          width: 30,
                        );
                })
            : const SizedBox()
      ],
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  confirmClearCart(BuildContext context) {
    var baseDialog = BaseAlertDialog(
        title: "Confirm",
        content: "Are your sure to clear cart?",
        yesOnPressed: () {
          categoryNotifier.deleteCartProductFromSF();
          Navigator.of(context).pop();
        },
        noOnPressed: () {
          Navigator.of(context).pop();
        },
        yes: "Yes",
        no: "No");
    showDialog(context: context, builder: (BuildContext context) => baseDialog);
  }
}
