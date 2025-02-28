import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:general_information/core/utils/app_colors.dart';
import 'package:general_information/core/utils/app_styles.dart';
import 'package:general_information/model/news_response_model/news_response_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsItemView extends StatelessWidget {
  const NewsItemView({super.key, required this.news});
  final News news;

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.tryParse(news.publishedAt ?? "") ?? DateTime.now();

    // /final dateTime = DateTime.parse(news.publishedAt ?? "").toLocal();

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: height * 0.02,
        horizontal: width * 0.04,
      ),
      padding: EdgeInsets.symmetric(
        vertical: height * 0.01,
        horizontal: width * 0.02,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 2,
          color: Theme.of(context).indicatorColor,
        ),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: news.urlToImage ?? "",
              placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                color: AppColors.greyColor,
              )),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            // child: Image.network(
            //   news.urlToImage ?? "",
            //   height: 200,
            //   width: double.infinity,
            //   fit: BoxFit.cover,
            // ),
          ),
          SizedBox(height: height * 0.02),
          Text(
            news.title ?? "",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          SizedBox(height: height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "By: ${news.author ?? ""}",
                  style: AppStyles.medium12Gray,
                ),
              ),
              Text(
                timeago.format(dateTime, locale: 'en'),
                // news.publishedAt ?? "",
                style: AppStyles.medium12Gray,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
