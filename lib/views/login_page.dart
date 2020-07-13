import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mojipanda/models/userinfo_model.dart';
import 'package:mojipanda/utils/crypto_util.dart';
import 'package:mojipanda/utils/data_util.dart';
import 'package:mojipanda/views/main_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  FocusNode _usernameFocusNode = new FocusNode();
  FocusNode _passwordFocusNode = new FocusNode();
  FocusScopeNode _focusScopeNode = new FocusScopeNode();

  GlobalKey<FormState> _signInFormKey = new GlobalKey();

  TextEditingController _userNameEditingController =
      new TextEditingController();
  TextEditingController _passwordEditingController =
      new TextEditingController();

  bool isShowPassWord = false;
  bool isLoading = false;
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // color: Theme.of(context).primaryColor,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Colors.white,
              image: DecorationImage(
                  image: new NetworkImage(
                      'https://cdn.jsdelivr.net/gh/xaoxuu/cdn-wallpaper/abstract/BBC19066-E176-47C2-9D22-48C81EE5DF6B.jpeg'),
                  fit: BoxFit.cover)),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
              //     color: Colors.white,
              //     image: DecorationImage(
              //         image: new NetworkImage(
              //             'https://cdn.jsdelivr.net/gh/xaoxuu/cdn-wallpaper/abstract/BBC19066-E176-47C2-9D22-48C81EE5DF6B.jpeg'),
              //         fit: BoxFit.cover)),
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 25.0),
                      buildSignInTextForm(),
                      buildSignInButton(),
                      SizedBox(height: 35.0),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    bottom: 0,
                    child: buildLoading(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSignInTextForm() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      height: 190,
      child: Form(
        key: _signInFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 20, bottom: 20),
                child: TextFormField(
                  controller: _userNameEditingController,
                  focusNode: _usernameFocusNode,
                  onEditingComplete: () {
                    if (_focusScopeNode == null) {
                      _focusScopeNode = FocusScope.of(context);
                    }
                    _focusScopeNode.requestFocus(_passwordFocusNode);
                  },
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.account_box,
                        color: Colors.black,
                      ),
                      hintText: 'username',
                      border: InputBorder.none),
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "登录名不可为空";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      username = value;
                    });
                  },
                ),
              ),
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width * 0.75,
              color: Colors.grey[400],
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
                child: TextFormField(
                  controller: _passwordEditingController,
                  focusNode: _passwordFocusNode,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    hintText: "password",
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: Colors.black,
                      ),
                      onPressed: showPassword,
                    ),
                  ),
                  obscureText: !isShowPassWord,
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "密码不能为空";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
              ),
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width * 0.75,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSignInButton() {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(left: 42, right: 42, top: 10, bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Theme.of(context).primaryColor),
        child: Text(
          "登录",
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
      ),
      onTap: () {
        if (_signInFormKey.currentState.validate()) {
          doLogin();
        }
      },
    );
  }

  Widget buildLoading() {
    if (isLoading) {
      return Opacity(
        opacity: .5,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: Colors.black,
          ),
          child: SpinKitPouringHourglass(color: Colors.white),
        ),
      );
    }
    return Container();
  }

  void showPassword() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }

  doLogin() async {
    print("doLogin");
    _signInFormKey.currentState.save();
    setState(() {
      isLoading = true;
    });
    Map<String, String> params = {
      'username': username,
      'password': CryptoUtil.sha1Digest(password),
    };
    UserInfoModel userInfo = await DataUtil.login(params);
    setState(() {
      isLoading = false;
    });
    if (userInfo != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MainPage()),
          (route) => route == null);
    }
  }
}
