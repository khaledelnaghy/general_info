import 'package:flutter/material.dart';
import 'package:general_information/core/providers/app_theme_provider.dart';
import 'package:general_information/core/utils/app_assets.dart';
import 'package:general_information/core/utils/app_colors.dart';
import 'package:general_information/core/utils/app_styles.dart';
import 'package:general_information/model/category/category_model.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CategoryFragment extends StatelessWidget {
  CategoryFragment({super.key, required this.onViewAllClicked});
  // var categoriesList = CategoryModel.getCategoriesList(true);

  Function onViewAllClicked;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var categoriesList = CategoryModel.getCategoriesList(
        themeProvider.appTheme == ThemeMode.dark);

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.04, vertical: height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Good Morning\nHere is Some News For You",
            style: AppStyles.medium20White.copyWith(
              color: themeProvider.appTheme == ThemeMode.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                height: height * 0.02,
              ),
              itemCount: categoriesList.length,
              itemBuilder: (context, index) {
                // return Stack(
                //   alignment: index % 2 == 0
                //       ? Alignment.bottomRight
                //       : Alignment.bottomLeft,
                //   children: [
                //     ClipRRect(
                //       borderRadius: BorderRadius.circular(16),
                //       child: Image.asset(
                //         categoriesList[index].imagePath,
                //         fit: BoxFit.cover, // اجعل الصورة تغطي المساحة بالكامل
                //         width: double.infinity,
                //         height: 200, // تأكد من تحديد ارتفاع مناسب
                //       ),
                //     ),
                //     Positioned(
                //       bottom: 20,
                //       left: index % 2 == 0 ? null : 20,
                //       right: index % 2 == 0 ? 20 : null,
                //       child: Container(
                //         color: themeProvider.appTheme == ThemeMode.dark
                //             ? Colors.white
                //             : Colors.black,
                //         padding:
                //             EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                //         child: Text(
                //           categoriesList[index].title,
                //           style: TextStyle(
                //             color: themeProvider.appTheme == ThemeMode.dark
                //                 ? Colors.black
                //                 : Colors.white,
                //             fontWeight: FontWeight.bold,
                //             fontSize: 18,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // );

                return Stack(
                  alignment: index % 2 == 0
                      ? Alignment.bottomRight
                      : Alignment.bottomLeft,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(AssetsManager.technologyDarkImage);
                        },
                        categoriesList[index].imagePath,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          bottom: height * 0.02,
                          right: width * 0.01,
                          left: width * 0.01),
                      child: ToggleSwitch(
                        customWidths: [width * 0.25, width * 0.14],
                        cornerRadius: 20.0,
                        activeBgColors: const [
                          [AppColors.blackColor],
                          [AppColors.greyColor]
                        ],
                        activeFgColor: Colors.white,
                        inactiveBgColor: AppColors.greyColor,
                        inactiveFgColor: Colors.white,
                        initialLabelIndex: 1,
                        totalSwitches: 2,
                        customWidgets: [
                          Text(
                            'View All',
                            style: AppStyles.bold16White,
                          ),
                          const CircleAvatar(
                            backgroundColor: AppColors.blackColor,
                            // radius: 70,
                            child: Icon(
                                color: AppColors.whiteColor,
                                Icons.arrow_forward_ios_outlined),
                          )
                        ],
                        animate: true,
                        radiusStyle: true,
                        onToggle: (index1) {
                          print('switched to: $index');
                          onViewAllClicked(categoriesList[index]);
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
