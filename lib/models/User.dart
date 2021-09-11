import 'package:intl/intl.dart';

class User {
  // todo: Properties
  static User? user;
  int id;
  int code;
  String login;
  String password;
  String name;
  String role;
  String email;
  String contact;
  String token;
  bool accountState;
  bool isConnected;
  DateTime lastLogin;
  DateTime createdAt;
  //todo: Constructor
  User({
    this.id = 0,
    this.code = 0,
    this.login = '',
    this.password = '',
    this.name = '',
    this.role = '',
    this.email = '',
    this.contact = '',
    this.token = '',
    this.accountState = false,
    this.isConnected = false,
    required this.lastLogin,
    required this.createdAt,
  });
  // todo: Methods
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: (json['id'] != null) ? json['id'] as int : 0,
      code: (json['code'] != null && json['code'] != 'null')
          ? json['code'] as int
          : 0,
      login: (json['login'] != null) ? json['login'] as String : '',
      password: (json['password'] != null) ? json['password'] as String : '',
      name: (json['full_name'] != null) ? json['full_name'] as String : '',
      role: (json['role'] != null) ? json['role'] as String : '',
      email: (json['email'] != null) ? json['email'] as String : '',
      contact: (json['contact'] != null) ? json['contact'] as String : '',
      token:
          (json['access_token'] != null) ? json['access_token'] as String : '',
      accountState:
          (json['statut_compte'] != null && json['statut_compte'] == 1)
              ? true
              : false,
      lastLogin: (json['updated_at'] != null)
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      createdAt: (json['created_at'] != null)
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      isConnected:
          (json['is_connected'] != null && json['is_connected'] != 'null')
              ? true
              : false,

      //print('createdAt: ' + DateFormat("yyyy-MM-dd HH:mm:ss").format(User.lastLogin)); // ! debug
    );
  }
  static Map<String, dynamic> toMap(User user) {
    return {
      //'token': User.token,
      'id': user.id,
      'code': user.code,
      'login': user.login,
      'password': user.password,
      'name': user.name,
      'role': user.role,
      'email': user.email,
      'contact': user.contact,
      'statut_compte': user.accountState,
      'updated_at': DateFormat('yyy-mm-dd HH:mm:ss').format(user.lastLogin),
      'created_at': DateFormat('yyy-mm-dd HH:mm:ss').format(user.createdAt),
    };
  }

  // get data from instance method
  factory User.fromInstance(User? user) {
    return (user != null)
        ? User(
            id: user.id,
            code: user.code,
            login: user.login,
            password: user.password,
            name: user.name,
            role: user.role,
            email: user.email,
            contact: user.contact,
            accountState: user.accountState,
            lastLogin: user.lastLogin,
            createdAt: user.createdAt,
          )
        : User.fromJson({});
  }
}
