import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constants.dart';

class WebViewPage extends StatefulWidget {
  final title;
  final url;
  const WebViewPage({Key? key, this.title, this.url}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late Completer<WebViewController> _controller =
      Completer<WebViewController>();
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    // if (Platform.isAndroid) {
    //   WebView.platform = SurfaceAndroidWebView();
    // }
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }
  // set controller(WebViewController controller) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: WebViewWidget(controller: controller),
      // body: WebView(
      //   initialUrl: widget.url,
      //   javascriptMode: JavascriptMode.unrestricted,
      //   onWebViewCreated: (controller) {
      //     //_controller.complete(webViewController);
      //     _controller.complete(controller);
      //   },
      //   onPageFinished: (url) {
      //     // _controller.runJavascriptReturningResult("function toMobile(){"
      //     //     "var meta = document.createElement('meta'); "
      //     //     "meta.setAttribute('name', 'viewport');"
      //     //     " meta.setAttribute('content', 'width=device-width, initial-scale=1'); "
      //     //     "var head= document.getElementsByTagName('head')[0];"
      //     //     "head.appendChild(meta); "
      //     //     "}"
      //     //     "toMobile()");
      //   },
      //   onProgress: (int progress) {
      //     print("WebView is loading (progress : $progress%)");
      //   },
      //   javascriptChannels: <JavascriptChannel>{
      //     // _toasterJavascriptChannel(context),
      //   },
      //   navigationDelegate: (NavigationRequest request) {
      //     if (request.url.startsWith('https://www.youtube.com/')) {
      //       print('blocking navigation to $request}');
      //       return NavigationDecision.prevent;
      //     }
      //     print('allowing navigation to $request');
      //     return NavigationDecision.navigate;
      //   },
      //   onPageStarted: (String url) {
      //     print('Page started loading: $url');
      //   },
      //   // onPageFinished: (String url) {
      //   //   print('Page finished loading: $url');
      //   // },
      //   gestureNavigationEnabled: true,
      // )
    );
  }
}
