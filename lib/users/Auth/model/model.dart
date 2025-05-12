// class User {
//   String? user_id;
//   String? user_name;
//   String? user_email;
//   String? user_password;

//   User({
//     this.user_id,
//     this.user_name,
//     this.user_email,
//     this.user_password,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'user_id': user_id.toString(),
//       'user_name': user_name.toString(),
//       'user_email': user_email.toString(),
//       'user_password': user_password.toString(),
//     };
//   }
// }

class User {
  // final String? userId;
  final String user_name;
  final String user_email;
  final String user_password;

  User({
    //this.userId,
    required this.user_name,
    required this.user_email,
    required this.user_password,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_name': user_name,
      // 'user_id': userId,
      'user_email': user_email,
      'user_password': user_password,
    };
  }
}
