import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  String? userId;
  String? errorMessage;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    notifyListeners();
  }

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        userId = value.user!.uid;
      });
      errorMessage = '';

      notifyListeners();
    } on FirebaseAuthException catch (error) {
      errorMessage = error.message!;
      notifyListeners();
    }
  }
}
