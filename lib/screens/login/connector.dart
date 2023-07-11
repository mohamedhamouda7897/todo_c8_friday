import 'package:todo_c8_friday/base.dart';
import 'package:todo_c8_friday/models/user_model.dart';

abstract class LoginConnector extends BaseNavigator {
  goToHome();

  readUser(UserModel userModel);
}
