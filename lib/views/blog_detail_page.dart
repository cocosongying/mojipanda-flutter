import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mojipanda/models/blog_model.dart';
import 'package:mojipanda/widgets/webview_title.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BlogDetailPage extends StatefulWidget {
  final Blog blog;
  BlogDetailPage({this.blog});
  @override
  _BlogDetailPageState createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  WebViewController _webViewController;
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
          WebViewPopupMenu(_webViewController, widget.blog),
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
}

class WebViewPopupMenu extends StatelessWidget {
  final WebViewController controller;
  final Blog blog;
  WebViewPopupMenu(this.controller, this.blog);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => <PopupMenuEntry<int>>[
        PopupMenuItem(
          child: WebViewPopupMenuItem(Icons.share, '分享'),
          value: 2,
        ),
      ],
      onSelected: (value) async {
        switch (value) {
          case 0:
            break;
          case 1:
            break;
          case 2:
            Share.share(blog.link);
            break;
        }
      },
    );
  }
}

class WebViewPopupMenuItem<T> extends StatelessWidget {
  final IconData iconData;
  final String text;
  WebViewPopupMenuItem(this.iconData, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          iconData,
          size: 20,
          color: Theme.of(context).textTheme.bodyText1.color,
        ),
        SizedBox(
          width: 20,
        ),
        Text(text),
      ],
    );
  }
}
