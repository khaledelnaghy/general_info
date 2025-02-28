import 'package:flutter/material.dart';
import 'package:general_information/core/apis/api_manger.dart';
import 'package:general_information/core/utils/app_colors.dart';
import 'package:general_information/feature/category/presentation/widget/source_tab_widget.dart';
import 'package:general_information/model/category/category_model.dart';
import 'package:general_information/model/source/source_model.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key, required this.categoryModel});

  static const String routeName = "CategoryView";
  final CategoryModel categoryModel;

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceResponse?>(
      future: ApiManger.getSources(widget.categoryModel.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.greyColor,
            ),
          );
        } else if (snapshot.hasError) {
          return Column(
            children: [
              Text("Something went wrong"),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    ApiManger.getSources(widget.categoryModel.id);
                  });
                },
                child: Text("Try again"),
              ),
            ],
          );
        }
        if (snapshot.data?.status != "ok") {
          return Column(
            children: [
              Text(snapshot.data?.message ?? ""),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    ApiManger.getSources(widget.categoryModel.id);
                  });
                },
                child: Text("Try again"),
              ),
            ],
          );
        }
        var sourceList = snapshot.data?.sources ?? [];
        return SourceTabWidget(sourceList: sourceList);
      },
    );
  }
}
