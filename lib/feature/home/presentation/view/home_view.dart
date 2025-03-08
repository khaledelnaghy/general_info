import 'package:flutter/material.dart';
import 'package:general_information/core/utils/app_colors.dart';
import 'package:general_information/feature/category/presentation/view/category_view.dart';
import 'package:general_information/feature/category/presentation/widget/category_fragment.dart';
import 'package:general_information/feature/drawer/presentation/view/drawer_view.dart';
import 'package:general_information/model/category/category_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeView extends StatefulWidget {
  static const String routeName = 'home_view';

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: AppColors.blackColor,
        child: DrawerView(
          onDrawerItemClicked: onDrawerItemClicked,
        ),
      ),
      appBar: AppBar(
        title: Text(
          selectedCategory == null
              ? AppLocalizations.of(context)!.home
              : selectedCategory!.title,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      body: selectedCategory == null
          ? CategoryFragment(
              onViewAllClicked: onViewAllClicked,
            )
          : CategoryView(
              categoryModel: selectedCategory!,
            ),
      // body: CategoryView(),
    );
  }

  CategoryModel? selectedCategory;

  void onViewAllClicked(CategoryModel newSelectedCategory) {
    setState(() {
      selectedCategory = newSelectedCategory;
    });
  }

  void onDrawerItemClicked() {
    setState(() {
      selectedCategory = null;
      Navigator.pop(context);
    });
  }
}
