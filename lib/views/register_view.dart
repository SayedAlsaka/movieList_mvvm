// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mvvm_demo/resources/strings_manager.dart';
import 'package:mvvm_demo/shared/components.dart';
import 'package:mvvm_demo/view_model/app_view_model.dart';
import 'package:mvvm_demo/view_model/register_view_model.dart';
import 'package:mvvm_demo/views/login_view.dart';
import 'package:provider/provider.dart';

import '../resources/colors_manager.dart';

class RegisterView extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var bioController = TextEditingController();

  RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<RegisterViewModel>(context, listen: false);
    var appProvider = Provider.of<AppViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<AppViewModel>(context).isChange,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.register.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.copyWith(color: Colors.black),
                    ),
                    Text(
                      AppStrings.registerNow,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    defaultFormField(
                      context: context,
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return AppErrorMessages.nameError;
                        }
                        return null;
                      },
                      label: AppStrings.name,
                      picon: Icons.person,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                      context: context,
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return AppErrorMessages.emailError;
                        }
                        return null;
                      },
                      label: AppStrings.email,
                      picon: Icons.email_outlined,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                      context: context,
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      isPassword:
                          Provider.of<RegisterViewModel>(context).isPassword,
                      sicon: Provider.of<RegisterViewModel>(context).suffix,
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
                      height: 15,
                    ),
                    defaultFormField(
                      context: context,
                      controller: bioController,
                      type: TextInputType.name,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return AppErrorMessages.bioError;
                        }
                        return null;
                      },
                      label: AppStrings.bio,
                      picon: Icons.book,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    defaultButton(
                      background: ColorManager.yellow,
                      function: () {
                        if (formKey.currentState!.validate()) {
                          appProvider.changeIsLoading(true);
                          provider
                              .userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  bio: bioController.text)
                              .then((value) {
                            appProvider.changeIsLoading(false);
                            navigateAndFinish(context, LoginView());
                          });
                        }
                      },
                      text: AppStrings.register,
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
