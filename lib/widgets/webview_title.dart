import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mojipanda/widgets/app_bar.dart';

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
