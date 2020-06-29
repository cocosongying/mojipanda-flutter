import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:mojipanda/views/main_page.dart';
import 'package:mojipanda/views/web_view_page.dart';

var mainHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MainPage();
});

var webViewPageHand = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String title = params['title']?.first;
  String url = params['url']?.first;
  return new WebViewPage(url, title);
});
