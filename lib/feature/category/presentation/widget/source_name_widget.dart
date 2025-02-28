import 'package:flutter/material.dart';
 import 'package:general_information/model/source/source_model.dart';

class SourceNameWidget extends StatelessWidget {
  const SourceNameWidget(
      {super.key, required this.source, required this.isSelected});
  final Source source;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Text(source.name ?? "",
        style: isSelected
            ? Theme.of(context).textTheme.headlineLarge
            : Theme.of(context).textTheme.headlineMedium);
  }
}
