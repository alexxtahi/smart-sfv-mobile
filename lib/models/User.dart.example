class User {
  // todo: Properties
  String login;
  //String password;
  String name;
  String role;
  static String token = '';
  // todo: Constructor
  User({
    required this.login,
    //required this.token,
    //required this.password,
    this.name = '',
    this.role = '',
  });
  // todo: Methods
  // get data from json method
  factory User.fromJson(Map<String, dynamic> json) {
    print("token: " + json['access_token']);
    return User(
      login: json['login'] as String,
      //password: json['password'] as String,
      name: json['full_name'] as String,
      role: json['role'] as String,
      //token: json['access_token'] as String,
    );
  }
}
