import 'package:flutter/material.dart';
import 'package:general_information/core/providers/app_theme_provider.dart';
import 'package:general_information/core/utils/app_styles.dart';
import 'package:general_information/feature/news/presentation/view/news_web_view.dart';
import 'package:general_information/model/news_response_model/news_response_model.dart';
import 'package:provider/provider.dart';

class NewsBottomSheet extends StatelessWidget {
  const NewsBottomSheet({super.key, required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
     var themeProvider = Provider.of<AppThemeProvider>(context);
    return Container(
      height: height * 0.6,
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.009,
      ),
      child: Column(
        children: [
          Container(
            height: height * 0.35,
            width: width * 0.96,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.network(news.urlToImage!, fit: BoxFit.cover),
          ),
          SizedBox(
            height: height * 0.015,
          ),
          Text(
            news.content!,
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: height * 0.015,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).indicatorColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewsWebView(url: news.url!)));
            },
            child: Container(
              alignment: Alignment.center,
              width: width * 0.877,
              height: height * 0.05,
              child: Text(
                "View Full Article",
                style: AppStyles.medium20White.copyWith(
                  color: themeProvider.appTheme == ThemeMode.dark
                      ? Colors.black
                      : Colors. white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

