import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:mojipanda/models/web_model.dart';

class WebViewPage extends StatefulWidget {
  final WebModel webModel;

  WebViewPage({this.webModel});

  @override
  _WebViewPageState createState() => new _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebviewScaffold(
        url: widget.webModel.url,
        withZoom: false,
        withLocalStorage: true,
        withJavascript: true,
        hidden: true,
      ),
    );
  }
}
