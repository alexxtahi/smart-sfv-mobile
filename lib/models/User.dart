import 'package:intl/intl.dart';

class User {
  // todo: Properties
  static String login = '';
  static String password = '';
  static String name = '';
  static String role = '';
  static String email = '';
  static String contact = '';
  static int id = 0;
  static int code = 0;
  static String token = '';
  static bool accountState = false;
  static DateTime lastLogin = DateTime.now();
  static DateTime createdAt = DateTime.now();
  static bool isConnected = false;
  // todo: Methods
  static void create(Map<String, dynamic> json) {
    // ? Login
    if (json['login'] != null && json['login'] != 'null')
      User.login = json['login'].toString();
    // ? Password
    if (json['password'] != null && json['password'] != 'null')
      User.password = json['password'].toString();
    // ? name
    if (json['full_name'] != null && json['full_name'] != 'null')
      User.name = json['full_name'].toString();
    // ? Role
    if (json['role'] != null && json['role'] != 'null')
      User.role = json['role'].toString();
    // ? Email
    if (json['email'] != null && json['email'] != 'null')
      User.email = json['email'].toString();
    // ? Contact
    if (json['contact'] != null && json['contact'] != 'null')
      User.contact = json['contact'].toString();
    // ? Id
    if (json['id'] != null && json['id'] != 'null') User.id = json['id'] as int;
    // ? Code
    if (json['code'] != null && json['code'] != 'null')
      User.code = json['code'] as int;
    // ? Token
    if (json['access_token'] != null && json['access_token'] != 'null')
      User.token = json['access_token'].toString();
    // ? Account state
    if (json['statut_compte'] != null &&
        json['statut_compte'] != 'null' &&
        json['statut_compte'] == 1) User.accountState = true;
    // ? Last login
    if (json['updated_at'] != null && json['updated_at'] != 'null')
      User.lastLogin = DateTime.parse(json['updated_at']);
    // ? Created at
    if (json['created_at'] != null && json['created_at'] != 'null')
      User.createdAt = DateTime.parse(json['created_at']);
    // ? Is Connected
    /*if (json['is_connected'] != null && json['is_connected'] != 'null')
      User.isConnected = true;*/

    //print('createdAt: ' + DateFormat("yyyy-MM-dd HH:mm:ss").format(User.lastLogin)); // ! debug
  }

  static Map<String, dynamic> toMap() {
    return {
      //'token': User.token,
      'login': User.login,
      'password': User.password,
      'name': User.name,
      'role': User.role,
      'email': User.email,
      'contact': User.contact,
      'id': User.id,
      'code': User.code,
      'accountState': User.accountState,
      'lastLogin': DateFormat('yyy-mm-dd HH:mm:ss').format(User.lastLogin),
      'createdAt': DateFormat('yyy-mm-dd HH:mm:ss').format(User.createdAt),
    };
  }
}
