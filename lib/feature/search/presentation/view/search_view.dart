import 'package:flutter/material.dart';
import 'package:general_information/core/providers/search_view_model.dart';
import 'package:general_information/feature/home/presentation/view/home_view.dart';
import 'package:general_information/feature/news/presentation/view/news_item_view.dart';
import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  static const String routeName = "Search";
  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  SearchViewModel searchView = SearchViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => searchView,
      child: Consumer<SearchViewModel>(builder: (context, viewModel, child) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04,
              vertical: MediaQuery.of(context).size.height * 0.04,
            ),
            child: Column(
              children: [
                buildSearchFile(context, viewModel),
                Expanded(
                  child: buildContent(context, viewModel),
                ),
              ],
            ),
          ),
        );
      }),
    );
    // return ChangeNotifierProvider(
    //   create: (_) => searchView,
    //   child: Consumer<SearchViewModel>(builder: (context, viewModel, child) {
    //     return Scaffold(
    //       body: Padding(
    //         padding: EdgeInsets.symmetric(
    //           horizontal: MediaQuery.of(context).size.width * 0.04,
    //           vertical: MediaQuery.of(context).size.height * 0.04,
    //         ),
    //         child: Column(
    //           children: [
    //             buildSearchFile(context, searchView),
    //             Expanded(
    //               child: buildContent(context, viewModel),
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   }),
    // );
  }

  Widget buildContent(BuildContext context, SearchViewModel viewModel) {
    if (viewModel.controller.text.isEmpty || viewModel.newsList == null) {
      return buildMessage(context, "Search for news By title or description");
    } else if (viewModel.errorMessage != null) {
      return buildError(context, viewModel);
    } else {
      return ListView.builder(
        itemBuilder: (context, index) => NewsItemView(
          news: viewModel.newsList![index],
        ),
        itemCount: viewModel.newsList!.length,
      );
    }
  }

  Widget buildSearchFile(BuildContext context, SearchViewModel viewModel) {
    return TextField(
      controller: viewModel.controller,
      onChanged: viewModel.onSearchChanged,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search_outlined,
          color: Theme.of(context).indicatorColor,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            viewModel.controller.clear();
            viewModel.onSearchChanged("");
            // Navigator.pop(context); // العودة بدلاً من الانتقال
            Navigator.of(context).pushReplacementNamed(HomeView.routeName);
          },
          icon: Icon(
            Icons.close,
            color: Theme.of(context).indicatorColor,
          ),
        ),
        hintText: "Search For News",
        hintStyle: Theme.of(context).textTheme.labelLarge,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            width: 2,
            color: Theme.of(context).indicatorColor,
          ),
        ),
      ),
    );
  }

  Widget buildMessage(BuildContext context, String message) {
    return Center(
      child: Text(
        message,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }

  Widget buildError(BuildContext context, SearchViewModel viewModel) {
    return Center(
      child: Text(
        viewModel.errorMessage!,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}
