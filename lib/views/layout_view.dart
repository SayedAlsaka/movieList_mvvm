import 'package:flutter/material.dart';
import 'package:mvvm_demo/view_model/profile_view_model.dart';
import 'package:mvvm_demo/views/home_view.dart';
import 'package:mvvm_demo/views/no_internet_view.dart';
import 'package:mvvm_demo/views/profile_view.dart';
import 'package:mvvm_demo/views/search_view.dart';
import 'package:mvvm_demo/views/settings_view.dart';
import 'package:provider/provider.dart';
import '../resources/strings_manager.dart';
import '../view_model/app_view_model.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0;

  final screens = [
    const HomeView(),
    const SearchView(),
    const ProfileView(),
    const SettingsView(),
  ];
  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<AppViewModel>(context, listen: false);
    var profileProvider = Provider.of<ProfileViewModel>(context, listen: false);
    appProvider.checkInternet();
    profileProvider.getUserData();
    if (Provider.of<AppViewModel>(context).hasInternet == true) {
      return SafeArea(
        child: Scaffold(
          body: screens[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) => setState(() => currentIndex = index),
            unselectedFontSize: 14,
            selectedFontSize: 14,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: AppStrings.homeView),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: AppStrings.searchView),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: AppStrings.profileView),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: AppStrings.settingsView),
            ],
          ),
        ),
      );
    } else if (Provider.of<AppViewModel>(context).hasInternet == false) {
      return const NoInternetView();
    }
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
