import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mojipanda/api/api.dart';
import 'package:mojipanda/generated/l10n.dart';
import 'package:mojipanda/models/app_updateInfo_model.dart';
import 'package:mojipanda/provider/provider_widget.dart';
import 'package:mojipanda/view_model/app_view_model.dart';
import 'package:mojipanda/widgets/button_progress_indicator.dart';
import 'package:oktoast/oktoast.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class AppUpdateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<AppUpdateViewModel>(
      model: AppUpdateViewModel(),
      builder: (_, model, __) => CupertinoButton(
          color: Theme.of(context).accentColor,
          child: model.isBusy
              ? ButtonProgressIndicator()
              : Text(S.of(context).appUpdateCheckUpdate),
          onPressed: model.isBusy
              ? null
              : () async {
                  AppUpdateInfo appUpdateInfo = await model.checkUpdate();
                  if (appUpdateInfo?.version != null ?? false) {
                    bool result =
                        await showUpdateAlertDialog(context, appUpdateInfo);
                    if (result == true) {
                      downloadApp(context, appUpdateInfo);
                    }
                  } else {
                    showToast(S.of(context).appUpdateLeastVersion);
                  }
                }),
    );
  }
}

Future checkAppUpdate(BuildContext context) async {
  if (!Platform.isAndroid) return;
  AppUpdateInfo appUpdateInfo = await AppUpdateViewModel().checkUpdate();
  if (appUpdateInfo?.version != null ?? false) {
    bool result = await showUpdateAlertDialog(context, appUpdateInfo);
    if (result == true) {
      downloadApp(context, appUpdateInfo);
    }
  }
}

showUpdateAlertDialog(context, AppUpdateInfo appUpdateInfo) async {
  var forceUpdate = appUpdateInfo.forceUpdate ?? false;
  return await showDialog(
    context: context,
    builder: (context) => WillPopScope(
      onWillPop: () async {
        return !forceUpdate;
      },
      child: AlertDialog(
        title: Text(
            S.of(context).appUpdateFoundNewVersion(appUpdateInfo.version)),
        content: appUpdateInfo.description != null
            ? Text(appUpdateInfo.description)
            : null,
        actions: <Widget>[
          if (!forceUpdate)
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: new Text(S.of(context).actionCancel),
            ),
          FlatButton(
            onPressed: () async {
              Navigator.of(context).pop(true);
            },
            child: Text(
              S.of(context).appUpdateActionUpdate,
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
          ),
        ],
      ),
    ),
  );
}

Future downloadApp(BuildContext context, AppUpdateInfo appUpdateInfo) async {
  var url = Api.BASE_URL + appUpdateInfo.downloadUrl;
  var extDir = await getExternalStorageDirectory();
  String apkPath =
      '${extDir.path}/mojipanda_${appUpdateInfo.version}_release.apk';
  File file = File(apkPath);
  if (!file.existsSync()) {
    if (await showDownloadDialog(context, url, apkPath) ?? false) {
      OpenFile.open(apkPath);
    }
  } else {
    var reDownload = await showReDownloadAlertDialog(context);
    if (reDownload != null) {
      if (reDownload) {
        if (await showDownloadDialog(context, url, apkPath) ?? false) {
          OpenFile.open(apkPath);
        }
      } else {
        OpenFile.open(apkPath);
      }
    }
  }
}

showDownloadDialog(context, url, path) async {
  DateTime lastBackPressed;
  CancelToken cancelToken = CancelToken();
  bool downloading = false;
  return await showCupertinoDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            if (lastBackPressed == null ||
                DateTime.now().difference(lastBackPressed) >
                    Duration(seconds: 1)) {
              //两次点击间隔超过1秒则重新计时
              lastBackPressed = DateTime.now();
              showToast(S.of(context).appUpdateDoubleBackTips,
                  position: ToastPosition.bottom);
              return false;
            }
            cancelToken.cancel();
            showToast(S.of(context).appUpdateDownloadCanceled,
                position: ToastPosition.bottom);
            return true;
          },
          child: CupertinoAlertDialog(
            title: Text(S.of(context).appUpdateDownloading),
            content: Builder(
              builder: (context) {
                ValueNotifier notifier = ValueNotifier(0.0);
                if (!downloading) {
                  downloading = true;
                  Dio().download(url, path, cancelToken: cancelToken,
                      onReceiveProgress: (progress, total) {
                    notifier.value = progress / total;
                  }).then((Response response) {
                    Navigator.pop(context, true);
                  }).catchError((onError) {
                    showToast(S.of(context).appUpdateDownloadFailed);
                  });
                }
                return ValueListenableBuilder(
                  valueListenable: notifier,
                  builder: (context, value, child) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(
                        value: value,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      });
}

showReDownloadAlertDialog(context) async {
  return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Text(S.of(context).appUpdateReDownloadContent),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  S.of(context).actionCancel,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text(
                  S.of(context).appUpdateActionDownloadAgain,
                ),
              ),
              FlatButton(
                onPressed: () async {
                  Navigator.of(context).pop(false);
                },
                child: Text(S.of(context).appUpdateActionInstallApk),
              ),
            ],
          ));
}
