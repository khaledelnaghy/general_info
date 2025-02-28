import 'package:flutter/material.dart';
import 'package:general_information/core/apis/api_manger.dart';
import 'package:general_information/core/utils/app_colors.dart';
import 'package:general_information/feature/news/presentation/view/news_item_view.dart';
import 'package:general_information/model/news_response_model/news_response_model.dart';
import 'package:general_information/model/source/source_model.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({
    super.key,
    required this.source,
  });
  final Source source;

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NewsResponse?>(
      future: ApiManger.getNewsBySourceId(widget.source.id ?? " "),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.greyColor,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              children: [
                Text("Something went wrong"),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      ApiManger.getNewsBySourceId(widget.source.id ?? " ");
                    });
                  },
                  child: Text("Try again"),
                ),
              ],
            ),
          );
        }
        if (snapshot.data!.status != "ok") {
          return Center(
            child: Column(
              children: [
                Text(snapshot.data?.message ?? ""),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      ApiManger.getNewsBySourceId(widget.source.id ?? " ");
                    });
                  },
                  child: Text("Try again"),
                ),
              ],
            ),
          );
        }
        var newsList = snapshot.data!.articles!;
        return ListView.builder(
            itemCount: newsList.length,
            itemBuilder: (context, index) {
              return NewsItemView(news:  newsList[index],);
            });
      },
    );
  }
}   
