import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_demo/models/user_model.dart';
import 'package:mvvm_demo/resources/constants_manager.dart';
import 'package:mvvm_demo/shared/network/local/cash_helper.dart';

class ProfileViewModel extends ChangeNotifier {
  late UserModel model ;


  Future<void> getUserData() async {
    AppConstants.uId = CashHelper.getData(key: 'uId');
    await FirebaseFirestore.instance
        .collection(AppConstants.userCollection)
        .doc(AppConstants.uId)
        .get()
        .then((value) {
      print(value.data());
      model = UserModel.fromJson(value.data()!);
      notifyListeners();
    }).catchError((error) {});
  }
}
