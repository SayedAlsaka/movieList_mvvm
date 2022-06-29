import 'package:flutter/material.dart';
import 'package:mvvm_demo/resources/strings_manager.dart';
import 'package:mvvm_demo/resources/values_manager.dart';
import 'package:mvvm_demo/view_model/app_view_model.dart';
import 'package:mvvm_demo/view_model/search_view_model.dart';
import 'package:mvvm_demo/view_model/settings_view_model.dart';
import 'package:mvvm_demo/views/login_view.dart';
import 'package:mvvm_demo/views/register_view.dart';
import 'package:provider/provider.dart';
import '../resources/constants_manager.dart';
import '../shared/components.dart';
import '../shared/network/local/cash_helper.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsViewModel>(context, listen: false);
    var appProvider = Provider.of<AppViewModel>(context, listen: false);
    AppConstants.uId = CashHelper.getData(key: 'uId');
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.p10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.appTheme,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.brightness_4_outlined,
                      size: AppSize.s30,
                    ),
                    onPressed: () {
                      appProvider.changeAppMode();
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: AppSize.s20,
              ),
              if (AppConstants.uId == null)
                defaultButton(
                    background: Colors.yellow,
                    function: () {
                      navigatePush(context, RegisterView());
                    },
                    text: AppStrings.settingButton),
              if (AppConstants.uId != null)
                defaultButton(
                    background: Theme.of(context).backgroundColor,
                    textColor: Colors.blue,
                    width: MediaQuery.of(context).size.width / 3,
                    shape: Border.all(color: Colors.grey),
                    function: () {
                      CashHelper.removeData(key: 'uId');
                      navigateAndFinish(context, LoginView());
                    },
                    text: AppStrings.signOutButton.toUpperCase()),
              const SizedBox(
                height: AppSize.s20,
              ),
              if (AppConstants.uId != null)
                defaultButton(
                    background: Theme.of(context).backgroundColor,
                    textColor: Colors.blue,
                    width: MediaQuery.of(context).size.width / 2,
                    shape: Border.all(color: Colors.grey),
                    function: () async{
                      await provider.deleteAccount(id:AppConstants.uId );
                      if(provider.errorMessage == '')
                        {
                          appProvider.changeIsLoading(true);
                          CashHelper.removeData(key: 'uId');
                          ScaffoldMessenger.of(context).showSnackBar(snackBar(
                              msg: AppStrings.accountDeleted,
                              state: ToastStates.SUCCESS));
                          appProvider.changeIsLoading(false);
                          navigateAndFinish(context, LoginView());
                        }
                    },
                    text: AppStrings.deleteAccount),
              const SizedBox(
                height: AppSize.s20,
              ),
              if (AppConstants.uId != null)
                defaultButton(
                    background: Theme.of(context).backgroundColor,
                    textColor: Colors.blue,
                    width: AppConstants.settingButtonWidth,
                    shape: Border.all(color: Colors.grey),
                    function: () {
                       Provider.of<SearchViewModel>(context, listen: false).clearSearchHistory();
                       ScaffoldMessenger.of(context).showSnackBar(snackBar(
                           msg: AppStrings.searchRecordsDeleted,
                           state: ToastStates.SUCCESS));
                    },
                    text: AppStrings.deleteSearchRecords),
              const SizedBox(
                height: AppSize.s20,
              ),
              if (AppConstants.uId != null)
                defaultButton(
                    background: Theme.of(context).backgroundColor,
                    textColor: Colors.blue,
                    width: AppConstants.settingButtonWidth,
                    shape: Border.all(color: Colors.grey),
                    function: () async{
                      await provider.deleteBookMarks(id: AppConstants.uId,context: context);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar(
                          msg: AppStrings.bookmarkRecordsDeleted,
                          state: ToastStates.SUCCESS));
                      appProvider.changeIsLoading(false);
                    },
                    text: AppStrings.deleteBookmarkRecords),
            ],
          ),
        ),
      ),
    );
  }
}
