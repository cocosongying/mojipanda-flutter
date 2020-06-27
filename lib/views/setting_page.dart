import 'package:flutter/material.dart';
import 'package:mojipanda/common/component_index.dart';
import 'package:mojipanda/models/language_model.dart';
import 'package:mojipanda/views/language_page.dart';
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
      appBar: new AppBar(
        title: new Text(IntlUtil.getString(context, Ids.titleSetting)),
      ),
      body: new ListView(
        children: <Widget>[
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
                NavigatorUtil.pushPage(context, LanguagePage(), pageName: Ids.titleLanguage);
              },)
        ],
      ),
    );
  }
}
