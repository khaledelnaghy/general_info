import 'package:flutter/material.dart';
import 'package:general_information/core/utils/app_colors.dart';
import 'package:general_information/feature/category/presentation/widget/source_name_widget.dart';
import 'package:general_information/feature/news/presentation/widget/news_widget.dart';
import 'package:general_information/model/source/source_model.dart';

class SourceTabWidget extends StatefulWidget {
  const SourceTabWidget({super.key, required this.sourceList});

  final List<Source> sourceList;

  @override
  State<SourceTabWidget> createState() => _SourceTabWidgetState();
}

class _SourceTabWidgetState extends State<SourceTabWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.sourceList.length,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            // labelPadding: EdgeInsets.zero,
            tabAlignment: TabAlignment.start,
            indicatorColor: Theme.of(context).indicatorColor,
            dividerColor: AppColors.transparentColor,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            tabs: widget.sourceList.map((source) {
              return SourceNameWidget(
                source: source,
                isSelected: selectedIndex == widget.sourceList.indexOf(source),
              );
            }).toList(),
          ),
          Expanded(
            child: NewsWidget(
              source: widget.sourceList[selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}
