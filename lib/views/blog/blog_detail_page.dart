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
          WebViewPopupMenu(widget.blog),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: WebView(
          initialUrl: widget.blog.link,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController controller) {
            widget.blog.controller = controller;
          },
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
  final Blog blog;
  WebViewPopupMenu(this.blog);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => <PopupMenuEntry<int>>[
        PopupMenuItem(
          child: WebViewPopupMenuItem(Icons.share, '分享'),
          value: 0,
        ),
        PopupMenuItem(
          child: WebViewPopupMenuItem(Icons.refresh, '刷新'),
          value: 1,
        ),
      ],
      onSelected: (value) async {
        switch (value) {
          case 0:
            Share.share(blog.link);
            break;
          case 1:
            blog.controller.reload();
            break;
          case 2:
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
