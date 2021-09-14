import 'package:smartsfv/models/User.dart';

class Auth {
  // todo: Properties
  static User? user;
  static String? token;
  // todo: Methods
  // Login save method
  static login({required String token, required User user}) {
    Auth.user = user;
    Auth.token = token;
  }

  // Logout method
  static logout() {
    Auth.user = null;
    Auth.token = null;
  }
}
