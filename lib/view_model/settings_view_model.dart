import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_demo/resources/constants_manager.dart';
import 'package:mvvm_demo/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

class SettingsViewModel extends ChangeNotifier {
  String? errorMessage;
  Future<void> deleteAccount({required id}) async {
    try {
      final docUser = FirebaseFirestore.instance
          .collection(AppConstants.userCollection)
          .doc(id);

      docUser.delete().then((value) async {
        await FirebaseAuth.instance.currentUser!.delete();
      });
      errorMessage = '';
      notifyListeners();
    } on FirebaseAuthException catch (error) {
      errorMessage = error.message!;
      notifyListeners();
    }
  }

  Future<void> deleteBookMarks({required id, required context}) async {
    await FirebaseFirestore.instance
        .collection(AppConstants.userCollection)
        .doc(id)
        .update({'bookMarks': []});
    Provider.of<ProfileViewModel>(context, listen: false).getUserData();
    notifyListeners();
  }
}
