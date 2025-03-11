// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:general_information/core/apis/api_manger.dart';
// import 'package:general_information/model/news_response_model/news_response_model.dart';

// class SearchViewModel extends ChangeNotifier {
//   List<News>? newsList;
//   String? errorMessage;
//   TextEditingController controller = TextEditingController();

//   Timer? debounce;

//   void onSearchChanged(String query) {
//     if (debounce?.isActive ?? false) {
//       debounce?.cancel();
//     }
//     debounce = Timer(const Duration(milliseconds: 500), () {
//       if (query.isNotEmpty) {
//         getNewsSearch(query);
//       } else {
//         errorMessage = null;
//         newsList = [];
//         notifyListeners();
//       }
//     });
//   }

//   void getNewsSearch(String query) async {
//     errorMessage = null;
//     try {
//       var response = await ApiManger.getNewsByQuery(query);
//       if (response.status == "error") {
//         errorMessage = response.message;
//       } else {
//         newsList = response.articles;
//       }
//     } catch (e) {
//       errorMessage = e.toString();
//       newsList = [];
//     }
//     notifyListeners();
//   }
// }
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:general_information/core/apis/api_manger.dart';
import 'package:general_information/model/news_response_model/news_response_model.dart';

class SearchViewModel extends ChangeNotifier {
  List<News>? newsList;
  String? errorMessage;
  TextEditingController controller = TextEditingController();
  Timer? debounce;

  void onSearchChanged(String query) {
    if (debounce?.isActive ?? false) {
      debounce?.cancel();
    }
    debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        getNewsSearch(query);
      } else {
        errorMessage = null;
        newsList = [];
        notifyListeners();
      }
    });
  }

  void getNewsSearch(String query) async {
    errorMessage = null;
    try {
      var response = await ApiManger.getNewsByQuery(query);
      if (response.status == "error") {
        errorMessage = response.message;
      } else {
        newsList = response.articles;
      }
    } catch (e) {
      errorMessage = e.toString();
      newsList = [];
    }
    notifyListeners();
  }

  @override
  void dispose() {
    debounce?.cancel(); // إلغاء الـ Timer
    controller.dispose(); // التخلص من الـ TextEditingController
    super.dispose();
  }
}