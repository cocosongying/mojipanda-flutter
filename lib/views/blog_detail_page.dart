import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mojipanda/models/blog_model.dart';
import 'package:mojipanda/views/web_detail_page.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BlogDetailPage extends StatefulWidget {
  final Blog blog;
  BlogDetailPage({this.blog});
  @override
  _BlogDetailPageState createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  Completer<bool> _finishedCompleter = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WebViewTitle(
          title: widget.blog.title,
          future: _finishedCompleter.future,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share(widget.blog.link);
            },
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: WebView(
          initialUrl: widget.blog.link,
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (String value) async {
            if (!_finishedCompleter.isCompleted) {
              _finishedCompleter.complete(true);
            }
          },
        ),
      ),
    );
  }
  //
}
