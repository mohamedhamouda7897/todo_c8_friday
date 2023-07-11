import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c8_friday/base.dart';
import 'package:todo_c8_friday/home_layout/home_layout.dart';
import 'package:todo_c8_friday/models/user_model.dart';
import 'package:todo_c8_friday/providers/my_provider.dart';
import 'package:todo_c8_friday/screens/signup/create_account.dart';
import 'package:todo_c8_friday/screens/login/login_viewmodel.dart';

import '../../firebase/firebase_functions.dart';
import 'connector.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseView<LoginViewModel, LoginScreen>
    implements LoginConnector {
  var usernameController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.connector = this;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      builder: (context, child) => Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              "assets/images/sign_in_bg.png",
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: usernameController,
                            validator: (value) {
                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value!);
                              if (value == null || value.isEmpty) {
                                return "Please enter Username";
                              } else if (!emailValid) {
                                return 'Please enter valid email';
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                                label: Text("Username"),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        BorderSide(color: Colors.blueAccent)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        BorderSide(color: Colors.blueAccent))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter password";
                              } else if (value.length < 6) {
                                return ' please enter at least 6 char';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                label: Text("Password"),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        BorderSide(color: Colors.blueAccent)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        BorderSide(color: Colors.blueAccent))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                viewModel.login(usernameController.text,
                                    passwordController.text);
                                // FirebaseFunctions.userLogin(
                                //     usernameController.text,
                                //     passwordController.text, () {
                                //   showDialog(
                                //     context: context,
                                //     barrierDismissible: false,
                                //     builder: (context) => AlertDialog(
                                //       title: Text("Error"),
                                //       actions: [
                                //         ElevatedButton(
                                //             onPressed: () {
                                //               Navigator.pop(context);
                                //             },
                                //             child: Text("Ok"))
                                //       ],
                                //       content: Text("Wrong Username or password"),
                                //     ),
                                //   );
                                // }, (usermodel) {

                                // });
                              }
                            },
                            child: Text("Login"),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Don't have an account?",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.black54, fontSize: 12),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, SignUpScreen.routeName);
                          },
                          child: Text(
                            "Create Account",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 13),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  goToHome() {
    Navigator.pushReplacementNamed(context, HomeLayout.routeName);
  }

  @override
  LoginViewModel initViewModel() {
    return LoginViewModel();
  }

  @override
  readUser(UserModel userModel) {
    Navigator.pushReplacementNamed(context, HomeLayout.routeName,
        arguments: userModel);
  }
}
