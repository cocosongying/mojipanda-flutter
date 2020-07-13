import 'package:flutter/material.dart';
import 'package:mojipanda/common/component_index.dart';
import 'package:mojipanda/models/language_model.dart';
import 'package:mojipanda/models/userinfo_model.dart';
import 'package:mojipanda/views/language_page.dart';
import 'package:mojipanda/views/about_page.dart';
import 'package:mojipanda/utils/navigator_util.dart';
import 'package:mojipanda/views/login_page.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingPageState();
  }
}

class _SettingPageState extends State<SettingPage> {
  bool isLogin = false;
  UserInfoModel _userInfoModel;

  @override
  void initState() {
    super.initState();
    _userInfoModel =
        SpUtil.getObj(Constant.keyUserInfo, (v) => UserInfoModel.fromJson(v));
    if (_userInfoModel != null) {
      isLogin = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);
    LanguageModel languageModel =
        SpUtil.getObj(Constant.keyLanguage, (v) => LanguageModel.fromJson(v));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 210,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://cdn.jsdelivr.net/gh/xaoxuu/cdn-wallpaper/abstract/BBC19066-E176-47C2-9D22-48C81EE5DF6B.jpeg'),
                    fit: BoxFit.cover)),
            child: isLogin
                ? Column(children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(top: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                                child: Container(
                                    alignment: Alignment.center,
                                    child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            _userInfoModel.userInfo.avatar),
                                        radius: 33.0)))
                          ],
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Text(
                            _userInfoModel.userInfo.nickname,
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        )
                      ],
                    )
                  ])
                : InkWell(
                    onTap: () => _toLogin(),
                    child: Column(children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: CircleAvatar(
                                          backgroundImage: NetworkImage(
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
                              "点击登录",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          )
                        ],
                      )
                    ]),
                  ),
          ),
          ExpansionTile(
            title: Row(
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
              Wrap(
                children: themeColorMap.keys.map((String key) {
                  Color value = themeColorMap[key];
                  return InkWell(
                      onTap: () {
                        SpUtil.putString(Constant.keyThemeColor, key);
                        bloc.sendAppEvent(Constant.type_sys_update);
                      },
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        width: 36.0,
                        height: 36.0,
                        color: value,
                      ));
                }).toList(),
              )
            ],
          ),
          ListTile(
            title: Row(children: <Widget>[
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
          ListTile(
            title: Row(children: <Widget>[
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
            trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Icon(Icons.keyboard_arrow_right),
            ]),
            onTap: () {
              NavigatorUtil.pushPage(context, AboutPage(),
                  pageName: Ids.titleAbout);
            },
          ),
          Container(
            width: double.infinity,
            height: 8.0,
            color: Color(0xFFF3F3F3),
          ),
          buildExitButton(),
        ],
      ),
    );
  }

  _toLogin() {
    NavigatorUtil.pushPage(context, LoginPage(), pageName: "登录");
  }

  Widget buildExitButton() {
    if (isLogin) {
      return InkWell(
        onTap: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text('退出登录?'),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () {
                        SpUtil.remove(Constant.keyUserInfo);
                        setState(() {
                          isLogin = false;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text('确定')),
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('取消')),
                ],
                backgroundColor: Colors.white,
                elevation: 20,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              );
            },
          );
        },
        child: Container(
          margin: const EdgeInsets.only(left: 35, right: 35),
          color: Colors.deepOrange,
          child: SizedBox(
            height: 50,
            child: Center(
              child: Text('退出登录',
                  style: TextStyle(fontSize: 18.0, color: Colors.white)),
            ),
          ),
        ),
      );
    }
    return Container();
  }
}
