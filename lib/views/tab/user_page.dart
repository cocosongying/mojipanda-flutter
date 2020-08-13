import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mojipanda/common/router_manager.dart';
import 'package:mojipanda/generated/l10n.dart';
import 'package:mojipanda/provider/provider_widget.dart';
import 'package:mojipanda/view_model/login_view_model.dart';
import 'package:mojipanda/view_model/theme_view_model.dart';
import 'package:mojipanda/view_model/user_view_model.dart';
import 'package:mojipanda/views/change_log_page.dart';
import 'package:mojipanda/widgets/app_bar.dart';
import 'package:mojipanda/widgets/bottom_clipper.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: <Widget>[
              ProviderWidget<LoginViewModel>(
                model: LoginViewModel(Provider.of(context)),
                builder: (context, model, child) {
                  if (model.isBusy) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: AppBarIndicator(),
                    );
                  }
                  if (model.userModel.hasUser) {
                    return IconButton(
                      tooltip: S.of(context).logout,
                      icon: Icon(Icons.exit_to_app),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                                  title: Text("退出登录?"),
                                  actions: <Widget>[
                                    CupertinoDialogAction(
                                      child: Text('取消'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    CupertinoDialogAction(
                                      child: Text('确定'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        model.logout();
                                      },
                                    ),
                                  ],
                                ));
                      },
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            expandedHeight: 200 + MediaQuery.of(context).padding.top,
            flexibleSpace: UserHeaderWidget(),
            pinned: false,
          ),
          UserListWidget(),
        ],
      ),
    );
  }
}

class UserHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomClipper(),
      child: Container(
        color: Theme.of(context).primaryColor.withAlpha(200),
        padding: EdgeInsets.only(top: 10),
        child: Consumer<UserViewModel>(
          builder: (context, model, child) => InkWell(
            onTap: model.hasUser
                ? null
                : () {
                    Navigator.of(context).pushNamed(RouteName.login);
                  },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: Hero(
                    tag: 'loginLogo',
                    child: ClipOval(
                        child: CircleAvatar(
                            backgroundImage: NetworkImage(model.hasUser
                                ? model.user.userInfo.avatar
                                : 'https://hbimg.huabanimg.com/9bfa0fad3b1284d652d370fa0a8155e1222c62c0bf9d-YjG0Vt_fw658'),
                            radius: 33.0)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      model.hasUser
                          ? model.user.userInfo.nickname
                          : S.of(context).toSignIn,
                      style: TextStyle(
                          color: Theme.of(context)
                                      .primaryColor
                                      .computeLuminance() <
                                  0.5
                              ? Colors.white
                              : Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var iconColor = Theme.of(context).accentColor;
    var model = Provider.of<UserViewModel>(context, listen: false);
    return ListTileTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 30),
      child: SliverList(
        delegate: SliverChildListDelegate([
          model.hasUser
              ? ListTile(
                  title: Text("网址收藏"),
                  onTap: () {
                    //
                  },
                  leading: Icon(
                    Icons.favorite,
                    color: iconColor,
                  ),
                  trailing: Icon(Icons.chevron_right),
                )
              : SizedBox(),
          SettingThemeWidget(),
          ListTile(
            title: Text(S.of(context).setting),
            onTap: () {
              Navigator.pushNamed(context, RouteName.setting);
            },
            leading: Icon(
              Icons.settings,
              color: iconColor,
            ),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text(S.of(context).appUpdateCheckUpdate),
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => ChangeLogPage(),
                  fullscreenDialog: true,
                ),
              );
            },
            leading: Icon(
              Icons.system_update,
              color: iconColor,
            ),
            trailing: Icon(Icons.chevron_right),
          ),
          SizedBox(
            height: 30,
          )
        ]),
      ),
    );
  }
}

class SettingThemeWidget extends StatelessWidget {
  SettingThemeWidget();

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(S.of(context).theme),
      leading: Icon(
        Icons.color_lens,
        color: Theme.of(context).accentColor,
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            children: <Widget>[
              ...Colors.primaries.map((color) {
                return Material(
                  color: color,
                  child: InkWell(
                    onTap: () {
                      var model =
                          Provider.of<ThemeViewModel>(context, listen: false);
                      model.switchTheme(color: color);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                    ),
                  ),
                );
              }).toList(),
              Material(
                child: InkWell(
                  onTap: () {
                    var model =
                        Provider.of<ThemeViewModel>(context, listen: false);
                    var brightness = Theme.of(context).brightness;
                    model.switchRandomTheme(brightness: brightness);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).accentColor)),
                    width: 40,
                    height: 40,
                    child: Text(
                      "?",
                      style: TextStyle(
                          fontSize: 20, color: Theme.of(context).accentColor),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
