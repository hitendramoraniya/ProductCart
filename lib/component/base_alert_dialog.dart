import 'package:flutter/material.dart';
import 'package:tech_task/res/app_color.dart';

class BaseAlertDialog extends StatelessWidget {
  String title;
  String content;
  String yes;
  String no;
  Function yesOnPressed;
  Function noOnPressed;

  BaseAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.yesOnPressed,
    required this.noOnPressed,
    this.yes = "Yes",
    this.no = "No",
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      backgroundColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      actions: <Widget>[
        ElevatedButton(
          style:
              ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
          child: Text(
            this.yes,
            style:
                const TextStyle(fontSize: 14, color: AppColors.textColorWhite),
          ),
          onPressed: () {
            yesOnPressed();
          },
        ),
        ElevatedButton(
          style:
              ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
          child: Text(
            no,
            style:
                const TextStyle(fontSize: 14, color: AppColors.textColorWhite),
          ),
          onPressed: () {
            noOnPressed();
          },
        ),
      ],
    );
  }
}
