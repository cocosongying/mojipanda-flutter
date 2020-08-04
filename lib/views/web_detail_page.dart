import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:mojipanda/models/web_model.dart';
import 'package:mojipanda/widgets/webview_title.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class WebDetailPage extends StatefulWidget {
  final WebModel webModel;
  WebDetailPage({this.webModel});

  @override
  _WebDetailPageState createState() => _WebDetailPageState();
}

class _WebDetailPageState extends State<WebDetailPage> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  Completer<bool> _finishedCompleter = Completer();

  @override
  void initState() {
    flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      if (!_finishedCompleter.isCompleted &&
          state.type == WebViewState.finishLoad) {
        _finishedCompleter.complete(true);
      }
    });
    flutterWebViewPlugin.onUrlChanged.listen((String url) {
      widget.webModel.current = url;
    });
    super.initState();
  }

  @override
  void dispose() {
    flutterWebViewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: WebViewTitle(
            title: widget.webModel.title,
            future: _finishedCompleter.future,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                Share.share(widget.webModel.current);
              },
            ),
          ],
        ),
        body: SafeArea(
          bottom: false,
          child: WebviewScaffold(
            url: widget.webModel.url,
            withJavascript: true,
            displayZoomControls: true,
            withZoom: true,
            bottomNavigationBar: IconTheme(
              data: Theme.of(context).iconTheme.copyWith(opacity: 0.8),
              child: BottomAppBar(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: flutterWebViewPlugin.goBack,
                    ),
                    IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: flutterWebViewPlugin.goForward),
                    IconButton(
                        icon: Icon(Icons.autorenew),
                        onPressed: flutterWebViewPlugin.reload),
                    IconButton(
                      icon: Icon(Icons.language),
                      onPressed: () {
                        launch(widget.webModel.current, forceSafariVC: false);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
