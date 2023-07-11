import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_c8_friday/base.dart';
import 'package:todo_c8_friday/firebase/firebase_functions.dart';
import 'package:todo_c8_friday/screens/login/connector.dart';

class LoginViewModel extends BaseViewModel<LoginConnector> {
  void login(String email, String password) async {
    try {
      connector!.showLoading("loading");
      var credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      connector!.goToHome();
      FirebaseFunctions.readUser(credential.user!.uid).then((value) {
        // getUser(value);
        connector!.readUser(value!);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // userNotFound();
        connector!.hideDialog();
        connector!.showMessage(e.message ?? "");
      } else if (e.code == 'wrong-password') {
        connector!.hideDialog();
        connector!.showMessage(e.message ?? "");
      }
    }
  }
}
