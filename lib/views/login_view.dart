// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mvvm_demo/resources/strings_manager.dart';
import 'package:mvvm_demo/resources/values_manager.dart';
import 'package:mvvm_demo/view_model/login_view_model.dart';
import 'package:mvvm_demo/views/layout_view.dart';
import 'package:mvvm_demo/views/register_view.dart';
import 'package:provider/provider.dart';
import '../resources/colors_manager.dart';
import '../shared/components.dart';
import '../shared/network/local/cash_helper.dart';
import '../view_model/app_view_model.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LoginViewModel>(context, listen: false);
    var appProvider = Provider.of<AppViewModel>(context, listen: false);

    return Scaffold(
      body: ModalProgressHUD(
        color: ColorManager.yellow,
        inAsyncCall: Provider.of<AppViewModel>(context).isChange,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p20),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.login.toUpperCase(),
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      AppStrings.loginNow,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    const SizedBox(
                      height: AppSize.s30,
                    ),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      context: context,
                      validate: (String? value) {
                        String pattern = r'\w+@\w+\.\w+';
                        RegExp regex = RegExp(pattern);
                        if (value!.isEmpty) {
                          return AppErrorMessages.emailError;
                        }
                        if (!regex.hasMatch(value)) {
                          return AppErrorMessages.emailError2;
                        }
                        return null;
                      },
                      label: AppStrings.email,
                      picon: Icons.email_outlined,
                    ),
                    const SizedBox(
                      height: AppSize.s15,
                    ),
                    defaultFormField(
                      context: context,
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      isPassword:
                          Provider.of<LoginViewModel>(context).isPassword,
                      sicon: Provider.of<LoginViewModel>(context).suffix,
                      suffixPressed: () {
                        provider.changePasswordVisibility();
                      },
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return AppErrorMessages.passwordError;
                        }
                        return null;
                      },
                      label: AppStrings.password,
                      picon: Icons.lock_outline,
                    ),
                    const SizedBox(
                      height: AppSize.s30,
                    ),
                    defaultButton(
                      background: ColorManager.yellow,
                      style: Theme.of(context).textTheme.headlineSmall!,
                      function: () async {
                        if (formKey.currentState!.validate()) {
                          appProvider.changeIsLoading(true);
                          await provider.userLogin(
                              email: emailController.text,
                              password: passwordController.text);
                          if (provider.errorMessage == '') {
                            appProvider.changeIsLoading(false);
                            CashHelper.saveData(
                              key: 'uId',
                              value: provider.userId,
                            ).then((value) {
                              navigateAndFinish(context, const MainView());
                            });
                            ScaffoldMessenger.of(context).showSnackBar(snackBar(
                                msg: AppStrings.loginSuccess,
                                state: ToastStates.SUCCESS));
                          } else {
                            appProvider.changeIsLoading(false);
                            ScaffoldMessenger.of(context).showSnackBar(snackBar(
                                msg: provider.errorMessage!,
                                state: ToastStates.ERROR));
                          }
                        }
                      },
                      text: AppStrings.login,
                    ),
                    const SizedBox(
                      height: AppSize.s30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.account,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        defaultTextButton(
                            function: () {
                              navigatePush(context, RegisterView());
                            },
                            text: AppStrings.registerNow),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
