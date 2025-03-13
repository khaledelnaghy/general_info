import 'package:flutter/material.dart';
import 'package:general_information/core/apis/api_manger.dart';
import 'package:general_information/core/utils/app_colors.dart';
import 'package:general_information/core/widget/news_bottom_sheet.dart';
import 'package:general_information/feature/news/data/model/news_widget_model.dart';
import 'package:general_information/feature/news/presentation/view/news_item_view.dart';
import 'package:general_information/model/news_response_model/news_response_model.dart';
import 'package:general_information/model/source/source_model.dart';
import 'package:provider/provider.dart';

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
  final ScrollController controller = ScrollController();
  NewsWidgetModel newsWidgetModel = NewsWidgetModel();
  int page = 1;
  List<News> articles = [];
  @override
  void initState() {
    super.initState();
    newsWidgetModel.getNewsBySourceId(widget.source.id ?? "");
    controller.addListener(() {
      if (controller.position.atEdge && controller.position.pixels != 0) {
        setState(() {
          ++page;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => newsWidgetModel,
      child: Consumer<NewsWidgetModel>(builder: (context, viewModel, child) {
        if (viewModel.errorMessage != null) {
          return Center(
            child: Column(
              children: [
                Text(viewModel.errorMessage!),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      ApiManger.getNewsBySourceId(
                          widget.source.id ?? " ", page);
                    });
                  },
                  child: Text("Try again"),
                ),
              ],
            ),
          );
        } else if (viewModel.newsList == null) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.greyColor,
            ),
          );
        } else {
          return ListView.builder(
              controller: controller,
              // itemCount: articles.length + 1,
              itemCount: viewModel.newsList!.length + 1,
              itemBuilder: (context, index) {
                if (index < viewModel.newsList!.length) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedBottomSheet(viewModel.newsList![index]);
                      });
                    },
                    child: NewsItemView(
                      news: viewModel.newsList![index],
                      // news: articles[index],
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.greyColor,
                    ),
                  );
                  // return ElevatedButton(
                  //   onPressed: () {
                  //     setState(() {
                  //       ++page;
                  //     });
                  //   },
                  //   child: Text("load more news"),
                  // );
                }
              });
        }
      }),
      //  FutureBuilder<NewsResponse>(
      //   //widget.source.id ?? " "
      //   future: ApiManger.getNewsBySourceId(widget.source.id!, page),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting &&
      //         articles.isEmpty) {
      // return Center(
      //   child: CircularProgressIndicator(
      //     color: AppColors.greyColor,
      //   ),
      // );
      //     } else if (snapshot.hasError) {
      // return Center(
      //   child: Column(
      //     children: [
      //       Text("Something went wrong"),
      //       ElevatedButton(
      //         onPressed: () {
      //           setState(() {
      //             ApiManger.getNewsBySourceId(
      //                 widget.source.id ?? " ", page);
      //           });
      //         },
      //         child: Text("Try again"),
      //       ),
      //     ],
      //   ),
      // );
      //     }
      //     if (snapshot.data!.status != "ok") {
      //       return Center(
      //         child: Column(
      //           children: [
      //             Text(snapshot.data?.message ?? ""),
      //             ElevatedButton(
      //               onPressed: () {
      //                 setState(() {
      //                   ApiManger.getNewsBySourceId(
      //                       widget.source.id ?? " ", page);
      //                 });
      //               },
      //               child: Text("Try again"),
      //             ),
      //           ],
      //         ),
      //       );
      //     }
      //     var newsList = snapshot.data!.articles!;
      //     articles.addAll(newsList);
      // return ListView.builder(
      //     controller: controller,
      //     itemCount: articles.length + 1,
      //     itemBuilder: (context, index) {
      //       if (index < articles.length) {
      //         return InkWell(
      //           onTap: () {
      //             setState(() {
      //               selectedBottomSheet(articles[index]);
      //             });
      //           },
      //           child: NewsItemView(
      //             news: articles[index],
      //           ),
      //         );
      //       } else {
      //         return Center(
      //           child: CircularProgressIndicator(
      //             color: AppColors.greyColor,
      //           ),
      //         );
      //         // return ElevatedButton(
      //         //   onPressed: () {
      //         //     setState(() {
      //         //       ++page;
      //         //     });
      //         //   },
      //         //   child: Text("load more news"),
      //         // );
      //       }
      //     });
      //   },
      // ),
    );
  }

  void selectedBottomSheet(News? news) {
    if (news == null) return; // تجنب تمرير null

    showBottomSheet(
      context: context,
      builder: (context) => NewsBottomSheet(news: news),
    );
  }
}
