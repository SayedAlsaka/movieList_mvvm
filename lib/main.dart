import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_demo/resources/constants_manager.dart';
import 'package:mvvm_demo/shared/network/local/cash_helper.dart';
import 'package:mvvm_demo/shared/styles/themes.dart';
import 'package:mvvm_demo/view_model/app_view_model.dart';
import 'package:mvvm_demo/view_model/home_view_model.dart';
import 'package:mvvm_demo/view_model/login_view_model.dart';
import 'package:mvvm_demo/view_model/movie_details_view_model.dart';
import 'package:mvvm_demo/view_model/profile_view_model.dart';
import 'package:mvvm_demo/view_model/register_view_model.dart';
import 'package:mvvm_demo/view_model/search_view_model.dart';
import 'package:mvvm_demo/view_model/settings_view_model.dart';
import 'package:mvvm_demo/views/layout_view.dart';
import 'package:mvvm_demo/views/login_view.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CashHelper.init();
  AppConstants.isDark = CashHelper.getBoolean(key: 'isDark');
  if (AppConstants.isDark == null) {
    AppConstants.isDark = false;
  } else {
    AppConstants.isDark = CashHelper.getBoolean(key: 'isDark');
  }

  AppConstants.uId = CashHelper.getData(key: 'uId');
  print(AppConstants.uId);
  print(AppConstants.isDark);
  if (AppConstants.uId == null) {
    AppConstants.widget = LoginView();
  } else {
    AppConstants.widget = MainView();
  }

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => SettingsViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        ChangeNotifierProvider(create: (_) => AppViewModel()),
        ChangeNotifierProvider(create: (_) => SearchViewModel()),
        ChangeNotifierProvider(create: (_) => MovieDetailsViewModel()),
      ],
      child: MyApp(
        startWidget: AppConstants.widget,
      )));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  MyApp({this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: Provider.of<AppViewModel>(context).isDark
          ? ThemeMode.dark
          : ThemeMode.light,
      home: startWidget,
    );
  }
}
