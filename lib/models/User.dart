
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
  static bool state = false;
  static DateTime lastLogin = DateTime.now();
  static DateTime createdAt = DateTime.now();
  // todo: Methods
  static void create(Map<String, dynamic> json) {
    User.login = json['login'];
    User.password = json['password'];
    User.name = json['full_name'];
    User.role = json['role'];
    User.email = json['email'];
    User.contact = json['contact'];
    User.id = json['id'];
    User.code = json['code'];
    User.token = json['access_token'];
    User.state = json['state'];
    if (json['lastLogin'] != null)
      User.lastLogin = DateTime.parse(json['lastLogin']);
    if (json['createdAt'] != null)
      User.createdAt = DateTime.parse(json['createdAt']);

    //print('createdAt: ' + DateFormat("yyyy-MM-dd HH:mm:ss").format(User.lastLogin)); // ! debug
  }
}
