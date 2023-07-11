import 'package:flutter/material.dart';

abstract class BaseNavigator {
  showLoading(String txt);

  showMessage(String message);

  hideDialog();
}

class BaseViewModel<NAV extends BaseNavigator> extends ChangeNotifier {
  NAV? connector;
}

abstract class BaseView<VM extends BaseViewModel, S extends StatefulWidget>
    extends State<S> implements BaseNavigator {
  late VM viewModel;

  VM initViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel = initViewModel();
  }

  @override
  hideDialog() {
    Navigator.pop(context);
  }

  @override
  showLoading(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
            child: Row(
          children: [CircularProgressIndicator(), Text(message)],
        )),
      ),
    );
  }

  @override
  showMessage(String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text(error),
      ),
    );
  }
}
