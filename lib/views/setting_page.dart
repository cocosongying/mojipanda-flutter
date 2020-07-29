import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mojipanda/generated/l10n.dart';
import 'package:mojipanda/utils/platform_util.dart';
import 'package:mojipanda/view_model/locale_view_model.dart';
import 'package:mojipanda/view_model/theme_view_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var iconColor = Theme.of(context).accentColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).setting,
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: <Widget>[
              Material(
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
              Material(
                child: ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        S.of(context).darkMode,
                        style: TextStyle(),
                      ),
                      Text(
                        ThemeViewModel.brightnessName(
                            Provider.of<ThemeViewModel>(context)
                                .brightnessIndex,
                            context),
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                  leading: Icon(
                    Theme.of(context).brightness == Brightness.light
                        ? Icons.brightness_5
                        : Icons.brightness_2,
                    color: iconColor,
                  ),
                  children: <Widget>[
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          var model = Provider.of<ThemeViewModel>(context);
                          return RadioListTile(
                            value: index,
                            onChanged: (index) {
                              model.switchBrightness(index);
                            },
                            groupValue: model.brightnessIndex,
                            title: Text(
                                ThemeViewModel.brightnessName(index, context)),
                          );
                        })
                  ],
                ),
              ),
              Material(
                child: ListTile(
                  title: Text('清除缓存'),
                  onTap: () async {
                    var cacheSize = await loadCache();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: Text('清除缓存'),
                          content: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                child: Text('缓存大小：$cacheSize'),
                                alignment: Alignment(0, 0),
                              )
                            ],
                          ),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              child: Text('取消'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            CupertinoDialogAction(
                              child: Text('确定'),
                              onPressed: () async {
                                Navigator.pop(context);
                                showToast('正在清除');
                                await delCache();
                                showToast('清除完成');
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  leading: Icon(
                    Icons.delete,
                    color: iconColor,
                  ),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future loadCache() async {
    Directory tempDir = await getTemporaryDirectory();
    double value = await getTotalSizeOfFilesInDir(tempDir);
    return renderSize(value);
  }

  Future delCache() async {
    Directory tempDir = await getTemporaryDirectory();
    await delDir(tempDir);
  }

  Future delDir(final FileSystemEntity file) async {
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      for (final FileSystemEntity child in children) {
        await delDir(child);
      }
    }
    await file.delete();
  }

  Future getTotalSizeOfFilesInDir(final FileSystemEntity file) async {
    if (file is File) {
      int length = await file.length();
      return double.parse(length.toString());
    }
    if (file is Directory) {
      final List children = file.listSync();
      double total = 0;
      if (children != null) {
        for (final FileSystemEntity child in children) {
          total += await getTotalSizeOfFilesInDir(child);
        }
      }
      return total;
    }
    return 0;
  }

  renderSize(double value) {
    if (value == null) {
      return '0';
    }
    List<String> unitList = List()..add('B')..add('K')..add('M')..add('G');
    int index = 0;
    while (value > 1024) {
      index++;
      value /= 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitList[index];
  }
}
