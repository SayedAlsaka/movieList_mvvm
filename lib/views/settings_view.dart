import 'package:flutter/material.dart';
import 'package:mvvm_demo/resources/strings_manager.dart';
import 'package:mvvm_demo/resources/values_manager.dart';
import 'package:mvvm_demo/view_model/app_view_model.dart';
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
                      //provider.changeAppMode();
                      appProvider.changeAppMode();

                    },
                  ),
                ],
              ),
              if (AppConstants.uId == null)
                defaultButton(
                  background: Colors.yellow,
                    function: () {
                      navigatePush(context, RegisterView());
                    },
                    text: AppStrings.settingButton),
              if(AppConstants.uId !=null)
                defaultButton(
                  background: Theme.of(context).backgroundColor,
                    textColor: Colors.blue,
                    width: MediaQuery.of(context).size.width/3,
                    shape: Border.all(
                        color: Colors.grey
                    ),
                    function: () {
                      CashHelper.removeDate(key: 'uId');
                      navigateAndFinish(context, LoginView());
                    },
                    text: AppStrings.signOutButton.toUpperCase()),
            ],
          ),
        ),
      ),
    );
  }
}
