class User {
  int id;
  String email;
  String username;
  bool is_client;
  bool is_superuser;
  List<dynamic> book_marks;
  String refresh;
  String access;

  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.is_client,
      required this.is_superuser,
      required this.access,
      required this.refresh,
      required this.book_marks});

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
        id: responseData["id"],
        username: responseData["username"],
        email: responseData["email"],
        is_client: responseData["is_client"],
        is_superuser: responseData["is_superuser"],
        access: responseData["access"],
        refresh: responseData["refresh"],
        book_marks: responseData["book_marks"]);
  }
}
