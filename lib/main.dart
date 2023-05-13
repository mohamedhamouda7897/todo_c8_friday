import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_c8_friday/firebase/firebase_functions.dart';
import 'package:todo_c8_friday/home_layout/home_layout.dart';
import 'package:todo_c8_friday/screens/update_task.dart';
import 'package:todo_c8_friday/shared/styles/my_theme.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseFirestore.instance.disableNetwork();
  FirebaseFunctions.delete();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: MyThemeData.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: HomeLayout.routeName,
      routes: {
        HomeLayout.routeName: (context) => HomeLayout(),
        UpdateTask.routeName: (context) => UpdateTask(),
      },
    );
  }
}
