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
  // todo: Methods
  static void create(Map<String, dynamic> json) {
    //User.login = json['login'];
    //User.password = json['password'];
    User.name = json['full_name'];
    User.role = json['role'];
    User.email = json['email'];
    User.contact = json['contact'];
    User.id = json['id'];
    User.code = json['code'];
    User.token = json['access_token'];
  }
}
