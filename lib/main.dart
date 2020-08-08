import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mojipanda/common/provider_manager.dart';
import 'package:mojipanda/common/router_manager.dart';
import 'package:mojipanda/common/storage_manager.dart';
import 'package:mojipanda/generated/l10n.dart';
import 'package:mojipanda/view_model/locale_view_model.dart';
import 'package:mojipanda/view_model/theme_view_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  runApp(App());
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}
