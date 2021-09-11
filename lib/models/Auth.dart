import 'package:smartsfv/models/User.dart';

class Auth {
  // todo: Properties
  static User? user;
  // todo: Methods
  // Login save method
  static login(User user) {
    Auth.user = user;
  }

  // Logout method
  static logout() {
    Auth.user = null;
  }
}
