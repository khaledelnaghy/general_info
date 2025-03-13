import 'package:flutter/material.dart';
import 'package:general_information/core/apis/api_manger.dart';
import 'package:general_information/model/source/source_model.dart';

class SouceDetailsModel extends ChangeNotifier {
  List<Source>? sourceList;
  String? errorMessage;
  void getSources(String categoryId) async {
    // reinitialize
    sourceList = null;
    errorMessage = null;
    notifyListeners();

    try {
      var response = await ApiManger.getSources(categoryId);

      if (response?.status == "error") {
        errorMessage = response?.message;
      } else {
        sourceList = response?.sources;
      }
    } catch (e) {
      errorMessage = "Error load Source List .";
      // errorMessage = errorMessage.toString();
    }
    notifyListeners();
  }
}
