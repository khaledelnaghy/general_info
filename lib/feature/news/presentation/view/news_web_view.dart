import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebView extends StatefulWidget {
  const NewsWebView({super.key, required this.url});

  final String url;

  @override
  State<NewsWebView> createState() => _NewsWebViewState();
}

class _NewsWebViewState extends State<NewsWebView> {
  late final WebViewController controller;
  var loadingPercentage = 0;
  @override
  void initState() {
    initalizedWebView();
    super.initState();
  }

  void initalizedWebView() {
    controller = WebViewController()
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              loadingPercentage = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageFinished: (url) {
            setState(
              () {
                loadingPercentage = 100;
              },
            );
          },
          onNavigationRequest: (request) {
            final host = Uri.parse(request.url).host;

            if (host.contains('www.bbc.co.uk')) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Site has been blocked"),
                ),
              );
              return NavigationDecision.prevent;
            } else {
              return NavigationDecision.navigate;
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              if (await controller.canGoBack()) {
                controller.goBack();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("No Back History Items"),
                  ),
                );
              }
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
            IconButton(
            onPressed: () async {
              if (await controller.canGoForward()) {
                controller.goForward();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("No Forward History Items"),
                  ),
                );
              }
            },
            icon: Icon(Icons.arrow_forward_ios),
          ),
          IconButton(
            onPressed: () async {
              controller.reload();
            },
            icon: Icon(Icons.replay),
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100,
            ),
        ],
      ),
    );
  }
}
