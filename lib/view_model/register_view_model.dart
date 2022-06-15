import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_demo/models/user_model.dart';
import 'package:mvvm_demo/resources/constants_manager.dart';

class RegisterViewModel extends ChangeNotifier {
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  String? errorMessage;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    notifyListeners();
  }

  Future<void> userRegister({
    required String name,
    required String email,
    required String password,
    required String bio,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await userCreate(
            name: name, email: email, bio: bio, uId: value.user!.uid);
      });
      errorMessage = '';
      notifyListeners();
    } on FirebaseAuthException catch (error) {
      errorMessage = error.message!;
      notifyListeners();
    }
  }

  Future<void> userCreate({
    required String name,
    required String email,
    required String bio,
    required uId,
  }) async {
    UserModel model = UserModel(
      id: uId,
      name: name,
      email: email,
      bio: bio,
    );

    await FirebaseFirestore.instance
        .collection(AppConstants.userCollection)
        .doc(uId)
        .set(model.toMap())
        .then((value) {})
        .catchError((error) {});
    notifyListeners();
  }
}
