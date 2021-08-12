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
  // todo: Methods
  static void create(Map<String, dynamic> json) {
    User.login = json['login'].toString();
    User.password = json['password'].toString();
    User.name = json['full_name'].toString();
    User.role = json['role'].toString();
    User.email = json['email'].toString();
    User.contact = json['contact'].toString();
    User.id = (json['id'] != null) ? json['id'] : 0;
    User.code = (json['code'] != null) ? json['code'] : 0;
    User.token = json['access_token'].toString();
    User.accountState =
        (json['statut_compte'] != null && json['statut_compte'] == 1)
            ? true
            : false;
    if (json['updated_at'] != null)
      User.lastLogin = DateTime.parse(json['updated_at']);
    if (json['created_at'] != null)
      User.createdAt = DateTime.parse(json['created_at']);

    //print('createdAt: ' + DateFormat("yyyy-MM-dd HH:mm:ss").format(User.lastLogin)); // ! debug
  }
}
