import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mojipanda/generated/l10n.dart';
import 'package:mojipanda/provider/view_state_widget.dart';
import 'package:mojipanda/widgets/app_update_widget.dart';
import 'package:package_info/package_info.dart';

class ChangeLogPage extends StatefulWidget {
  @override
  _ChangeLogPageState createState() => _ChangeLogPageState();
}

class _ChangeLogPageState extends State<ChangeLogPage> {
  ValueNotifier versionNotifier;

  @override
  void initState() {
    versionNotifier = ValueNotifier<String>('');
    PackageInfo.fromPlatform().then((packageInfo) {
      versionNotifier.value =
          '${packageInfo.version}(${packageInfo.buildNumber})';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder(
            valueListenable: versionNotifier,
            builder: (ctx, value, child) => Text(
                  S.of(context).appUpdateCheckUpdate + ' v$value',
                  style: TextStyle(fontSize: 16),
                )),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 10),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          child: Container(
                              alignment: Alignment.center,
                              child: new ClipOval(
                                child: SizedBox(
                                  width: 80.0,
                                  height: 80.0,
                                  child: Image.asset("assets/images/logo.png"),
                                ),
                              )))
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      '磨叽熊猫',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Divider(height: 10.0, indent: 0.0),
            ]),
            Padding(
              padding: const EdgeInsets.only(bottom: 75, top: 130),
              child: ChangeLogView(),
            ),
            Positioned(
              left: 30,
              right: 30,
              bottom: 8,
              child: Platform.isIOS
                  ? CupertinoButton(
                      color: Theme.of(context).accentColor,
                      child: Text(S.of(context).close),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                  : AppUpdateButton(),
            ),
          ],
        ),
      ),
    );
  }
}

class ChangeLogView extends StatefulWidget {
  @override
  _ChangeLogViewState createState() => _ChangeLogViewState();
}

class _ChangeLogViewState extends State<ChangeLogView> {
  String _changelog;

  @override
  void initState() {
    _changelog = '## hello';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_changelog == null) {
      return ViewStateBusyWidget();
    }
    return Markdown(data: _changelog);
  }
}
