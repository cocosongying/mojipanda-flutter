import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mojipanda/generated/l10n.dart';
import 'package:mojipanda/models/web_model.dart';
import 'package:mojipanda/widgets/app_bar.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebDetailPage extends StatefulWidget {
  final WebModel webModel;
  WebDetailPage({this.webModel});

  @override
  _WebDetailPageState createState() => _WebDetailPageState();
}

class _WebDetailPageState extends State<WebDetailPage> {
  WebViewController _webViewController;
  Completer<bool> _finishedCompleter = Completer();

  ValueNotifier canGoBack = ValueNotifier(false);
  ValueNotifier canGoForward = ValueNotifier(false);

  @override
  void initState() {
    widget.webModel.current = widget.webModel.url;
    super.initState();
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
          WebViewPopupMenu(
            webModel: widget.webModel,
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: WebView(
          initialUrl: widget.webModel.url,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            widget.webModel.current = request.url;
            return NavigationDecision.navigate;
          },
          onWebViewCreated: (WebViewController controller) {
            _webViewController = controller;
            widget.webModel.controller = controller;
          },
          onPageFinished: (String value) async {
            if (!_finishedCompleter.isCompleted) {
              _finishedCompleter.complete(true);
            }
            refreshNavigator();
          },
        ),
      ),
    );
  }

  void refreshNavigator() {
    _webViewController.canGoBack().then((value) {
      return canGoBack.value = value;
    });

    _webViewController.canGoForward().then((value) {
      return canGoForward.value = value;
    });
  }
}

class WebViewTitle extends StatelessWidget {
  final String title;
  final Future<bool> future;
  WebViewTitle({this.title, this.future});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        FutureBuilder<bool>(
          future: future,
          initialData: false,
          builder: (context, snapshot) => snapshot.data
              ? SizedBox.shrink()
              : Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: AppBarIndicator(),
                ),
        ),
        Expanded(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class WebViewPopupMenu extends StatelessWidget {
  final WebModel webModel;

  WebViewPopupMenu({this.webModel});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => <PopupMenuEntry<int>>[
        PopupMenuItem(
          child: WebViewPopupMenuItem(Icons.autorenew, S.of(context).refresh),
          value: 0,
        ),
        PopupMenuItem(
          child:
              WebViewPopupMenuItem(Icons.language, S.of(context).openBrowser),
          value: 1,
        ),
        PopupMenuItem(
          child: WebViewPopupMenuItem(Icons.share, S.of(context).share),
          value: 2,
        ),
      ],
      onSelected: (value) async {
        switch (value) {
          case 0:
            webModel.controller.reload();
            break;
          case 1:
            launch(webModel.current, forceSafariVC: false);
            break;
          case 2:
            Share.share(webModel.title + ' ' + webModel.current);
            break;
        }
      },
    );
  }
}

class WebViewPopupMenuItem<T> extends StatelessWidget {
  final IconData iconData;
  final Color color;
  final String text;

  WebViewPopupMenuItem(this.iconData, this.text, {this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          iconData,
          size: 18,
          color: color ?? Theme.of(context).textTheme.bodyText1.color,
        ),
        SizedBox(
          width: 18,
        ),
        Text(text),
      ],
    );
  }
}
