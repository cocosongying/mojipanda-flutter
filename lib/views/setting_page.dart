import 'package:flutter/material.dart';
import 'package:mojipanda/common/component_index.dart';
import 'package:mojipanda/models/language_model.dart';
import 'package:mojipanda/views/language_page.dart';
import 'package:mojipanda/views/about_page.dart';
import 'package:mojipanda/utils/navigator_util.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SettingPageState();
  }
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);
    LanguageModel languageModel =
        SpUtil.getObj(Constant.keyLanguage, (v) => LanguageModel.fromJson(v));
    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(),
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            height: 210,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: new NetworkImage(
                        'https://cdn.jsdelivr.net/gh/xaoxuu/cdn-wallpaper/abstract/BBC19066-E176-47C2-9D22-48C81EE5DF6B.jpeg'),
                    fit: BoxFit.cover)),
            child: new Column(children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 25),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          child: Container(
                              alignment: Alignment.center,
                              child: new CircleAvatar(
                                  backgroundImage: new NetworkImage(
                                      'https://hbimg.huabanimg.com/9bfa0fad3b1284d652d370fa0a8155e1222c62c0bf9d-YjG0Vt_fw658'),
                                  radius: 33.0)))
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Text(
                      "磨叽熊猫",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  )
                ],
              )
            ]),
          ),
          new ExpansionTile(
            title: new Row(
              children: <Widget>[
                Icon(
                  Icons.color_lens,
                  color: Colours.gray_66,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      IntlUtil.getString(context, Ids.titleTheme),
                    ))
              ],
            ),
            children: <Widget>[
              new Wrap(
                children: themeColorMap.keys.map((String key) {
                  Color value = themeColorMap[key];
                  return new InkWell(
                      onTap: () {
                        SpUtil.putString(Constant.keyThemeColor, key);
                        bloc.sendAppEvent(Constant.type_sys_update);
                      },
                      child: new Container(
                        margin: EdgeInsets.all(5.0),
                        width: 36.0,
                        height: 36.0,
                        color: value,
                      ));
                }).toList(),
              )
            ],
          ),
          new ListTile(
            title: new Row(children: <Widget>[
              Icon(
                Icons.language,
                color: Colours.gray_66,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  IntlUtil.getString(context, Ids.titleLanguage),
                ),
              ),
            ]),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Text(
                languageModel == null
                    ? IntlUtil.getString(context, Ids.languageAuto)
                    : IntlUtil.getString(context, languageModel.titleId,
                        languageCode: 'zh', countryCode: 'CH'),
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colours.gray_99,
                ),
              ),
              Icon(Icons.keyboard_arrow_right)
            ]),
            onTap: () {
              NavigatorUtil.pushPage(context, LanguagePage(),
                  pageName: Ids.titleLanguage);
            },
          ),
          new ListTile(
            title: new Row(children: <Widget>[
              Icon(
                Icons.info_outline,
                color: Colours.gray_66,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  IntlUtil.getString(context, Ids.titleAbout),
                ),
              ),
            ]),
            trailing: new Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.keyboard_arrow_right),
              ]
            ),
            onTap: () {
              NavigatorUtil.pushPage(context, AboutPage(),
                  pageName: Ids.titleAbout);
            },
          ),
        ],
      ),
    );
  }
}
