import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c8_friday/firebase/firebase_functions.dart';
import 'package:todo_c8_friday/home_layout/home_layout.dart';
import 'package:todo_c8_friday/screens/login/login.dart';
import 'package:todo_c8_friday/screens/signup/connector.dart';
import 'package:todo_c8_friday/screens/signup/signup_viewmodel.dart';

import '../../base.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = 'signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends BaseView<SignUpViewModel, SignUpScreen>
    implements SignUpConnector {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var ageController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.connector = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      builder: (context, child) => Scaffold(
        resizeToAvoidBottomInset: false,
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
                            controller: nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter name";
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                                label: Text("Name"),
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
                            controller: ageController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter age";
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                                label: Text("Age"),
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
                            controller: emailController,
                            validator: (value) {
                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value!);
                              if (value == null || value.isEmpty) {
                                return "Please enter Email";
                              } else if (!emailValid) {
                                return 'Please enter valid email';
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                                label: Text("Email Address"),
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
                            obscureText: true,
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
                                viewModel.createAccount(
                                    emailController.text,
                                    passwordController.text,
                                    nameController.text,
                                    ageController.text);
                                // FirebaseFunctions.createAuthAccount(
                                //     nameController.text,
                                //     ageController.text,
                                //     emailController.text,
                                //     passwordController.text, () {
                                //   Navigator.pushReplacementNamed(
                                //       context, HomeLayout.routeName);
                                // });
                              }
                            },
                            child: Text("Sign Up"),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "I have an account?",
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
                                context, LoginScreen.routeName);
                          },
                          child: Text(
                            "Login",
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
  void afterCreate() {
    Navigator.pushReplacementNamed(context, HomeLayout.routeName);
  }

  @override
  SignUpViewModel initViewModel() {
    return SignUpViewModel();
  }
}
