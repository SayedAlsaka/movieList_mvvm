import 'package:flutter/material.dart';
import 'package:mvvm_demo/resources/colors_manager.dart';
import 'package:mvvm_demo/view_model/app_view_model.dart';
import 'package:provider/provider.dart';

import '../view_model/settings_view_model.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error ,color: ColorManager.error),
                Text('No Internet' , style: Theme.of(context).textTheme.bodyText1,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
