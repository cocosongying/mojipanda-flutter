import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mojipanda/common/storage_manager.dart';
import 'package:mojipanda/generated/l10n.dart';
import 'package:mojipanda/provider/provider_widget.dart';
import 'package:mojipanda/view_model/login_view_model.dart';
import 'package:mojipanda/widgets/button_progress_indicator.dart';
import 'package:mojipanda/widgets/login_field_widget.dart';
import 'package:mojipanda/widgets/login_widget.dart';

import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _pwdFocus = FocusNode();

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _pwdFocus.unfocus();
    _pwdFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyHeight = MediaQuery.of(context).viewInsets.bottom;
    if (keyHeight != 0) {
      StorageManager.localStorage.setItem("kHeight", keyHeight);
    }
    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: <Widget>[
                LoginTopPanel(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      LoginLogo(),
                      LoginFormContainer(
                          child: ProviderWidget<LoginViewModel>(
                        model: LoginViewModel(Provider.of(context)),
                        onModelReady: (model) {
                          _nameController.text = model.getLoginName();
                        },
                        builder: (context, model, child) {
                          return Form(
                            onWillPop: () async {
                              return !model.isBusy;
                            },
                            child: child,
                          );
                        },
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              LoginTextField(
                                label: S.of(context).userName,
                                icon: Icons.perm_identity,
                                controller: _nameController,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (text) {
                                  FocusScope.of(context)
                                      .requestFocus(_pwdFocus);
                                },
                              ),
                              LoginTextField(
                                controller: _passwordController,
                                label: S.of(context).password,
                                icon: Icons.lock_outline,
                                obscureText: true,
                                focusNode: _pwdFocus,
                                textInputAction: TextInputAction.done,
                              ),
                              LoginButton(_nameController, _passwordController),
                            ]),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final nameController;
  final passwordController;

  LoginButton(this.nameController, this.passwordController);

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<LoginViewModel>(context);
    return LoginButtonWidget(
      child: model.isBusy
          ? ButtonProgressIndicator()
          : Text(
              S.of(context).signIn,
              style: Theme.of(context)
                  .accentTextTheme
                  .subtitle1
                  .copyWith(wordSpacing: 6),
            ),
      onPressed: model.isBusy
          ? null
          : () {
              var formState = Form.of(context);
              if (formState.validate()) {
                model
                    .login(nameController.text, passwordController.text)
                    .then((value) {
                  if (value) {
                    Navigator.of(context).pop(true);
                  } else {
                    model.showErrorMessage(context);
                  }
                });
              }
            },
    );
  }
}
