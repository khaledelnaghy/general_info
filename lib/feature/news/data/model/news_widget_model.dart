import 'package:flutter/material.dart';
import 'package:general_information/core/apis/api_manger.dart';
import 'package:general_information/model/news_response_model/news_response_model.dart';

class NewsWidgetModel extends ChangeNotifier {
  List<News>? newsList;
  String? errorMessage;
  void getNewsBySourceId(String sourceId) async {
    errorMessage = null;
    newsList = null ;
    notifyListeners();
    try {
      var resposne = await ApiManger.getNewsByPage(sourceId);
      if (resposne?.status == "error") {
        errorMessage = resposne?.message;
      } else {
        newsList = resposne?.articles;
      }
    } catch (e) {
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
