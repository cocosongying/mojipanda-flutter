import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mojipanda/generated/l10n.dart';
import 'package:mojipanda/view_model/locale_view_model.dart';
import 'package:mojipanda/view_model/theme_view_model.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var iconColor = Theme.of(context).accentColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).setting),
      ),
      body: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: <Widget>[
              Material(
                // color: Theme.of(context).cardColor,
                child: ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(S.of(context).settingFont),
                      Text(
                        ThemeViewModel.fontName(
                            Provider.of<ThemeViewModel>(context, listen: false)
                                .fontIndex,
                            context),
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                  leading: Icon(
                    Icons.font_download,
                    color: iconColor,
                  ),
                  children: <Widget>[
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: ThemeViewModel.fontValueList.length,
                        itemBuilder: (context, index) {
                          var model = Provider.of<ThemeViewModel>(context,
                              listen: false);
                          return RadioListTile(
                            value: index,
                            onChanged: (index) {
                              model.switchFont(index);
                            },
                            groupValue: model.fontIndex,
                            title:
                                Text(ThemeViewModel.fontName(index, context)),
                          );
                        })
                  ],
                ),
              ),
              Material(
                // color: Theme.of(context).cardColor,
                child: ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        S.of(context).settingLanguage,
                        style: TextStyle(),
                      ),
                      Text(
                        LocaleViewModel.localeName(
                            Provider.of<LocaleViewModel>(context).localeIndex,
                            context),
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                  leading: Icon(
                    Icons.public,
                    color: iconColor,
                  ),
                  children: <Widget>[
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: LocaleViewModel.localeValueList.length,
                        itemBuilder: (context, index) {
                          var model = Provider.of<LocaleViewModel>(context);
                          return RadioListTile(
                            value: index,
                            onChanged: (index) {
                              model.switchLocale(index);
                            },
                            groupValue: model.localeIndex,
                            title: Text(
                                LocaleViewModel.localeName(index, context)),
                          );
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
