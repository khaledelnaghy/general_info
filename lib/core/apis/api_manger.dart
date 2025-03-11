import 'dart:convert';

import 'package:general_information/core/constant/api_constant.dart';
import 'package:general_information/core/constant/end_point.dart';
import 'package:general_information/model/news_response_model/news_response_model.dart';
import 'package:general_information/model/source/source_model.dart';
import 'package:http/http.dart' as http;

//https://newsapi.org/v2/top-headlines/sources?apiKey=6cf7e62ce6ea40078c9f55d96d041e26
class ApiManger {
  static Future<SourceResponse?> getSources(String categoryId) async {
    Uri url = Uri.https(ApiConstant.baseUrl, EndPoint.endPoint,
        {"apiKey": ApiConstant.apikey, "category": categoryId});
    try {
      var response = await http.get(url);
      // var bodyString = response.body;
      // var json = jsonDecode(bodyString);
      // SourceModel.fromJson(json);
      return SourceResponse.fromJson(
        jsonDecode(response.body),
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<NewsResponse> getNewsBySourceId(
      String sourceId, int page) async {
    Uri url = Uri.https(
      ApiConstant.baseUrl,
      EndPoint.newsApi,
      {
        "apiKey": ApiConstant.apikey,
        "sources": sourceId,
        "pageSize": "2",
        "page": "$page",
      },
    );
    try {
      var response = await http.get(url);
      return NewsResponse.fromJson(
        jsonDecode(response.body),
      );
    } catch (e) {
      throw e;
    }
  }

  static Future<NewsResponse?> getNewsByPage(String sourceId) async {
    Uri url = Uri.https(
      ApiConstant.baseUrl,
      EndPoint.newsApi,
      {
        "apiKey": ApiConstant.apikey,
        "sources": sourceId,
      },
    );
    try {
      var response = await http.get(url);
      return NewsResponse.fromJson(
        jsonDecode(response.body),
      );
    } catch (e) {
      throw e;
    }
  }
  static Future<NewsResponse>  getNewsByQuery(
      String  query, ) async {
    Uri url = Uri.https(
      ApiConstant.baseUrl,
      EndPoint.newsApi,
      {
        "apiKey": ApiConstant.apikey,
         "q" : query , 
      },
    );
    try {
      var response = await http.get(url);
      return NewsResponse.fromJson(
        jsonDecode(response.body),
      );
    } catch (e) {
      throw e;
    }
  }
}
