import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c8_friday/models/user_model.dart';
import 'package:todo_c8_friday/providers/my_provider.dart';
import 'package:todo_c8_friday/screens/login.dart';
import 'package:todo_c8_friday/screens/settingsScreen.dart';
import 'package:todo_c8_friday/screens/tasks.dart';
import 'package:todo_c8_friday/screens/widgets/show_add_task_bottom_sheet.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = "HomeLayout";

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                provider.signOut();
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                FirebaseCrashlytics.instance.crash();
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
        title: Text(
          "Todo App${provider.myUser?.name}",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAddTaskSheet();
          },
          shape: const StadiumBorder(
              side: BorderSide(color: Colors.white, width: 3)),
          child: const Icon(Icons.add)),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconSize: 30,
          currentIndex: index,
          onTap: (value) {
            index = value;
            setState(() {});
          },
          items: [
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                ),
                label: ""),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: ""),
          ],
        ),
      ),
      body: tabs[index],
    );
  }

  List<Widget> tabs = [TaskScreen(), SettingsScreen()];

  void showAddTaskSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return ShowAddTaskBottomSheet();
      },
    );
  }
}
