import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mojipanda/common/component_index.dart';
import 'package:mojipanda/utils/net_util.dart';
import 'package:mojipanda/utils/package_info_util.dart';

class AboutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AboutPageState();
  }
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(IntlUtil.getString(context, Ids.titleAbout),
            style: new TextStyle(fontSize: 16.0)),
      ),
      body: ListView(
        children: <Widget>[
          new Column(children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 40),
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
                                child: Image.asset("images/logo.png"),
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
                    PackageInfoUtil.getAppName(),
                    style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 40),
                  child: Text(
                    "Version " + PackageInfoUtil.getVersion(),
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ],
            )
          ]),
          Divider(height:10.0,indent:0.0),
          ListTile(
            title: new Row(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  IntlUtil.getString(context, Ids.checkUpdate),
                ),
              ),
            ]),
            trailing:
                new Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Icon(Icons.keyboard_arrow_right),
            ],),
            onTap: () {
              try {
                getUpdateVersion();
              } catch (e) {
                FlutterToast.showToast(msg: "网络错误");
              }
            }
          ),
        ],
      ),
    );
  }

  static getUpdateVersion() async {
    final result = await NetUtil.get("https://mojipanda.com/api/app/all?name=mp-apk");
    if (result['code'] == 0) {
      String version = result['data']['list'][0]['version'];
      if (version == PackageInfoUtil.getVersion()) {
        FlutterToast.showToast(msg: "已是最新版本");
      } else {
        FlutterToast.showToast(msg: "检测到新版本");
      }
    } else {
      FlutterToast.showToast(msg: "网络错误");
    }
  }
}
