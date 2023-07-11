import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_c8_friday/base.dart';
import 'package:todo_c8_friday/firebase/firebase_functions.dart';
import 'package:todo_c8_friday/screens/signup/connector.dart';

import '../../models/user_model.dart';

class SignUpViewModel extends BaseViewModel<SignUpConnector> {
  void createAccount(
      String email, String password, String name, String age) async {
    try {
      connector!.showLoading("loading");
      var credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel user = UserModel(
        id: credential.user!.uid,
        name: name,
        email: email,
        age: age,
      );
      FirebaseFunctions.addUserToFirestore(user).then((value) {
        connector!.afterCreate();
        // Navigator.pushReplacementNamed(context, routeName);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        connector!.showMessage(e.message!);
      } else if (e.code == 'email-already-in-use') {
        connector!.showMessage(e.message!);
      }
    } catch (e) {
      connector!.showMessage(e.toString()!);
    }
  }
}
