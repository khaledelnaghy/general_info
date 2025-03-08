import 'package:flutter/material.dart';
import 'package:general_information/core/providers/app_lang_provider.dart';
import 'package:general_information/core/providers/app_theme_provider.dart';
import 'package:general_information/core/utils/app_assets.dart';
import 'package:general_information/core/utils/app_colors.dart';
import 'package:general_information/core/utils/app_styles.dart';
import 'package:general_information/feature/drawer/presentation/widget/drawer_items.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DrawerView extends StatefulWidget {
  const DrawerView({super.key, required this.onDrawerItemClicked});

  final Function onDrawerItemClicked;

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
//Function => عشان الكلكاية موجودة في الدريور والاكشن هيتم في الهوم فيو
  String selectedLanguage = "English";
  String selectedTheming = "Light";

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var langProvider = Provider.of<AppLangProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
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
              widget.onDrawerItemClicked();
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
          width: double.infinity,
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
          child: DropdownButton<String>(
            value: selectedTheming,
            dropdownColor: AppColors.greyColor,
            style: AppStyles.medium20White,
            icon: Icon(
              Icons.arrow_drop_down,
              size: 30,
              color: AppColors.whiteColor,
            ),
            underline: SizedBox(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedTheming = newValue;
                  themeProvider.changeTheme(
                      newValue == "Dark" ? ThemeMode.dark : ThemeMode.light);
                });
              }
            },
            items: <String>['Dark', 'Light']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Row(
                  children: [
                    Text(value, style: AppStyles.medium20White),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.39),
                  ],
                ),
              );
            }).toList(),
          ),
          // child: Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       "Dark",
          //       style: AppStyles.medium20White,
          //     ),
          //     Icon(
          //       Icons.arrow_drop_down,
          //       size: 30,
          //       color: AppColors.whiteColor,
          //     ),
          //   ],
          // ),
        ),
        Divider(
          color: AppColors.whiteColor,
          thickness: 2,
          indent: width * 0.06,
          endIndent: width * 0.06,
        ),
        DrawerItems(imagePath: AssetsManager.languageIcon, text: "Language"),
        Container(
          width: double.infinity,
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

          // child: InkWell(
          //   onTap: () {
          //     setState(() {
          //       DropdownMenu(
          //         dropdownMenuEntries: <DropdownMenuEntry>[
          //           DropdownMenuEntry(
          //               value: AppStyles.medium20White, label: "ar"),
          //           DropdownMenuEntry(
          //               value: AppStyles.medium20White, label: "en"),
          //         ],
          //       );
          //     });
          //   },
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         "English",
          //         style: AppStyles.medium20White,
          //       ),
          //       Icon(
          //         Icons.arrow_drop_down,
          //         size: 30,
          //         color: AppColors.whiteColor,
          //       ),
          //     ],
          //   ),
          // ),
          child: DropdownButton<String>(
            value: selectedLanguage,
            dropdownColor: AppColors.greyColor,
            style: AppStyles.medium20White,
            icon: Icon(
              Icons.arrow_drop_down,
              size: 30,
              color: AppColors.whiteColor,
            ),
            underline: SizedBox(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedLanguage = newValue;
                  langProvider.changeLange(newValue == "Arabic" ? "ar" : "en");
                });
              }
            },
            items: <String>['English', 'Arabic']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Row(
                  children: [
                    Text(value, style: AppStyles.medium20White),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.39),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
