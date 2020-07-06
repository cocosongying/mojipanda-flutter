import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mojipanda/common/component_index.dart';
import 'package:mojipanda/routers/routers.dart';
import 'package:mojipanda/common/global.dart';
import 'package:mojipanda/utils/package_info_util.dart';

void main() {
  Global.init(() {
    runApp(BlocProvider<ApplicationBloc>(
      bloc: ApplicationBloc(),
      child: BlocProvider(
        child: MainApp(),
        bloc: MainBloc(),
      ),
    ));
  });
}

class MainApp extends StatefulWidget {
  @override
  MainApp() {
    FluroRouter.initRouter();
  }
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Locale _locale;
  Color _themeColor = Colours.app_main;

  @override
  void initState() {
    super.initState();
    setInitDir(initStorageDir: true);
    setLocalizedSimpleValues(localizedSimpleValues);
    // setLocalizedValues
    init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: FluroRouter.router.generator,
      theme: ThemeData.light().copyWith(
        primaryColor: _themeColor,
        accentColor: _themeColor,
        indicatorColor: Colors.white,
      ),
      locale: _locale,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        CustomLocalizations.delegate
      ],
      supportedLocales: CustomLocalizations.supportedLocales,
    );
  }

  void init() {
    // _init();
    _initListener();
    _loadLocale();
    PackageInfoUtil.init();
  }

  void _initListener() {
    final ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);
    bloc.appEventStream.listen((value) {
      _loadLocale();
    });
  }

  void _loadLocale() {
    setState(() {
      LanguageModel model =
          SpUtil.getObj(Constant.keyLanguage, (v) => LanguageModel.fromJson(v));
      if (model != null) {
        _locale = new Locale(model.languageCode, model.countryCode);
      } else {
        _locale = null;
      }

      String _colorKey = SpHelper.getThemeColor();
      if (themeColorMap[_colorKey] != null)
        _themeColor = themeColorMap[_colorKey];
    });
  }
}
