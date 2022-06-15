import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mvvm_demo/resources/constants_manager.dart';

import '../shared/network/local/cash_helper.dart';

class SettingsViewModel extends ChangeNotifier {

  String? errorMessage;
  Future<void> deleteAccount({
    required id
  }) async {
    try {
      final docUser = FirebaseFirestore.instance.collection(AppConstants.userCollection).doc(id);

      docUser.delete().then((value) async{
        await FirebaseAuth.instance.currentUser!.delete();
      });
      errorMessage = '';
      notifyListeners();
    } on FirebaseAuthException catch (error) {
      errorMessage = error.message!;
      notifyListeners();
    }
  }

}
