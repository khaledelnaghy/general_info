import 'package:flutter/material.dart';
import 'package:general_information/core/utils/app_assets.dart';
import 'package:general_information/core/utils/app_colors.dart';
import 'package:general_information/core/utils/app_styles.dart';
import 'package:general_information/feature/drawer/presentation/widget/drawer_items.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({super.key, required this.onDrawerItemClicked});

  final Function onDrawerItemClicked;

//Function => عشان الكلكاية موجودة في الدريور والاكشن هيتم في الهوم فيو
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: height * 0.20,
          color: AppColors.whiteColor,
          child: Text(
            "News App",
            style: AppStyles.bold24Black,
          ),
        ),
        InkWell(
            onTap: () {
              onDrawerItemClicked();
            },
            child: DrawerItems(
                imagePath: AssetsManager.homeIcon, text: "Go To Home")),
        Divider(
          color: AppColors.whiteColor,
          thickness: 2,
          indent: width * 0.06,
          endIndent: width * 0.06,
        ),
        DrawerItems(imagePath: AssetsManager.themeIcon, text: "Theme"),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: width * 0.04, vertical: height * 0.01),
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.04, vertical: height * 0.01),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.whiteColor,
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Dark",
                style: AppStyles.medium20White,
              ),
              Icon(
                Icons.arrow_drop_down,
                size: 30,
                color: AppColors.whiteColor,
              ),
            ],
          ),
        ),
        Divider(
          color: AppColors.whiteColor,
          thickness: 2,
          indent: width * 0.06,
          endIndent: width * 0.06,
        ),
        DrawerItems(imagePath: AssetsManager.languageIcon, text: "Language"),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: width * 0.04, vertical: height * 0.01),
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.04, vertical: height * 0.01),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.whiteColor,
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "English",
                style: AppStyles.medium20White,
              ),
              Icon(
                Icons.arrow_drop_down,
                size: 30,
                color: AppColors.whiteColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
