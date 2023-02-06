import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  Icon leadingIcon;
  String title;
  bool isSelected;
  VoidCallback onTap;

  DrawerItem({super.key,
    required this.leadingIcon, required this.title, required this.isSelected, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leadingIcon,
      title: Text(title),
      onTap: onTap,
    );
  }
}
