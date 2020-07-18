import 'package:mojipanda/view_model/locale_view_model.dart';
import 'package:mojipanda/view_model/theme_view_model.dart';
import 'package:mojipanda/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders,
];

/// 独立的viewmodel
List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider<ThemeViewModel>(
    create: (context) => ThemeViewModel(),
  ),
  ChangeNotifierProvider<LocaleViewModel>(
    create: (context) => LocaleViewModel(),
  ),
  ChangeNotifierProvider<UserViewModel>(
    create: (context) => UserViewModel(),
  ),
  // ChangeNotifierProvider<GlobalFavouriteStateModel>(
  //   create: (context) => GlobalFavouriteStateModel(),
  // ),
];

/// 需要依赖的viewmodel
List<SingleChildWidget> dependentServices = [
];

/// 
List<SingleChildWidget> uiConsumableProviders = [
];
