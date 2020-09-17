import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mojipanda/common/provider_manager.dart';
import 'package:mojipanda/common/router_manager.dart';
import 'package:mojipanda/common/storage_manager.dart';
import 'package:mojipanda/common/websocket_manager.dart';
import 'package:mojipanda/event/event_bus.dart';
import 'package:mojipanda/event/event_model.dart';
import 'package:mojipanda/generated/l10n.dart';
import 'package:mojipanda/view_model/locale_view_model.dart';
import 'package:mojipanda/view_model/theme_view_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/logo');
  var initializationSettingsIOS = IOSInitializationSettings();
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    // TODO 点击通知事件
  });
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  WebSocketManager.create();
  runApp(App());
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ),
  );
}

class App extends StatelessWidget {
  App() {
    final eventBus = EventBus();
    ApplicationEvent.event = eventBus;
  }
  @override
  Widget build(BuildContext context) {
    ApplicationEvent.event.on<MsgEvent>().listen((event) {
      print(event.msg);
      showSimple(0, '磨', event.msg);
    });
    return OKToast(
      child: MultiProvider(
        providers: providers,
        child: Consumer2<ThemeViewModel, LocaleViewModel>(
          builder: (context, themeViewModel, localeViewModel, child) {
            return themeViewModel.brightnessIndex == 0
                ? RefreshConfiguration(
                    hideFooterWhenNotFull: true,
                    child: MaterialApp(
                      debugShowCheckedModeBanner: false,
                      theme: themeViewModel.themeData(),
                      darkTheme:
                          themeViewModel.themeData(platformDarkMode: true),
                      locale: localeViewModel.locale,
                      localizationsDelegates: const [
                        S.delegate,
                        RefreshLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate
                      ],
                      supportedLocales: S.delegate.supportedLocales,
                      onGenerateRoute: Router.generateRoute,
                      initialRoute: RouteName.splash,
                    ),
                  )
                : RefreshConfiguration(
                    hideFooterWhenNotFull: true,
                    child: MaterialApp(
                      debugShowCheckedModeBanner: false,
                      theme: themeViewModel.brightnessIndex == 1
                          ? themeViewModel.themeData()
                          : themeViewModel.themeData(platformDarkMode: true),
                      locale: localeViewModel.locale,
                      localizationsDelegates: const [
                        S.delegate,
                        RefreshLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate
                      ],
                      supportedLocales: S.delegate.supportedLocales,
                      onGenerateRoute: Router.generateRoute,
                      initialRoute: RouteName.splash,
                    ),
                  );
          },
        ),
      ),
    );
  }

  static Future showSimple(int id, String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channelId', 'channelName', 'channelDescription');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    flutterLocalNotificationsPlugin
        .show(id, title, body, platformChannelSpecifics, payload: 'hello');
  }
}
