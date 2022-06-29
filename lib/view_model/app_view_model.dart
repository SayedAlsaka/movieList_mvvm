import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mvvm_demo/resources/constants_manager.dart';
import '../shared/network/local/cash_helper.dart';

class AppViewModel extends ChangeNotifier {
  bool? hasInternet;

  Future<void> checkInternet() async {
    hasInternet = await InternetConnectionChecker().hasConnection;
    notifyListeners();
  }

  bool isChange = false;
  changeIsLoading(bool value) {
    isChange = value;
    notifyListeners();
  }

  bool isDark = AppConstants.isDark!;
  void changeAppMode() {
    isDark = !isDark;
    print(isDark);
    CashHelper.putBoolean(key: 'isDark', value: isDark);
    notifyListeners();
  }
}
