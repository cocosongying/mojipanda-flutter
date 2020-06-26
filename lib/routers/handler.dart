import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:mojipanda/views/main_page.dart';

var mainHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MainPage();
});
