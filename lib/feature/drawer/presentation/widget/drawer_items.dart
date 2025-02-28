import 'package:flutter/material.dart';
import 'package:general_information/core/utils/app_colors.dart';
import 'package:general_information/core/utils/app_styles.dart';

class DrawerItems extends StatelessWidget {
  const DrawerItems({super.key, required this.imagePath, required this.text});

  final String imagePath;
  final String text;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.01,
      ),
      child: Row(
        children: [
          ImageIcon(
            AssetImage(
              imagePath,
            ),
            color: AppColors.whiteColor,
          ),
          SizedBox(
            width: width * 0.02,
          ),
          Text(
            text,
            style: AppStyles.bold20White,
          )
        ],
      ),
    );
  }
}
