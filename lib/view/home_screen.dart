import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tech_task/component/drawer_item.dart';
import 'package:tech_task/notifier/category_notifier.dart';
import 'package:tech_task/res/app_color.dart';
import 'package:tech_task/res/app_string.dart';
import 'package:tech_task/view/cart_screen.dart';
import 'package:tech_task/view/category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: const SafeArea(child: CategoryScreen()),
      drawer: SafeArea(child: DrawerMenu()),
    );
  }

  AppBar AppBarWidget() {
    return AppBar(
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu_rounded, color: AppColors.primaryColor),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      backgroundColor: AppColors.whiteColor,
      title: Center(
        child: Text(
          AppString.instance.category,
          style: const TextStyle(color: AppColors.textColorBlack),
        ),
      ),
      actions: <Widget>[
        //Profile Pic
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartScreen(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Icon(
              Icons.shopping_cart_outlined,
              color: AppColors.blackColor,
              size: 30,
            ),
          ),
        ),
      ],
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  Widget DrawerMenu() {
    return Drawer(
      elevation: 0,
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
            ), //BoxDecoration
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: AppColors.primaryColor),
              accountName: Text(
                "Flutter Test",
                style: TextStyle(fontSize: 18, color: AppColors.textColorWhite),
              ),
              accountEmail: Text(
                "fluttertest@gmail.com",
                style: TextStyle(color: AppColors.textColorWhite),
              ),
              currentAccountPictureSize: Size.square(50),
              currentAccountPicture: CircleAvatar(
                backgroundColor: AppColors.whiteColor,
                child: Text("F",
                    style: TextStyle(
                        fontSize: 30.0, color: AppColors.textColorBlack)),
              ),
            ),
          ),
          DrawerItem(
            leadingIcon: const Icon(Icons.category),
            title: AppString.instance.category,
            onTap: () {
              Navigator.pop(context);
            },
            isSelected: true,
          ),
          DrawerItem(
            leadingIcon: const Icon(Icons.person),
            title: AppString.instance.profile,
            onTap: () {
              Navigator.pop(context);
            },
            isSelected: true,
          ),
          ValueListenableBuilder(
            valueListenable: categoryNotifier.cartProductList,
            builder: (context, cartProductList, child) {
              return DrawerItem(
                  leadingIcon: const Icon(Icons.shopping_cart),
                  title:
                      "${cartProductList.data.length} ${AppString.instance.items}",
                  isSelected: false,
                  onTap: () {
                    Navigator.pop(context);
                  });
            },
          ),
        ],
      ),
    );
  }
}
