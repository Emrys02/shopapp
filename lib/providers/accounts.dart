import 'package:flutter/material.dart';

class Acct {
  String id;
  String username;
  String password;
  bool isAdmin;
  String gender;
  int phoneNumber;
  String email;
  String firstName;
  String lastName;
  Acct(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.password,
      required this.username,
      required this.gender,
      required this.email,
      this.isAdmin = false,
      required this.phoneNumber});
}

class AcctDetails with ChangeNotifier {
  bool loginStatus = false;
  bool adminState = false;

  final List<Acct> _users = [
    Acct(
      id: DateTime.now().toString(),
      password: "password",
      username: "username",
      firstName: "Elaigwu",
      lastName: "Emmanuel",
      email: "example@email.com",
      gender: "Male",
      isAdmin: true,
      phoneNumber: 12345678,
    ),
  ];

  RegExp passwordPattern = RegExp(r"[0-9a-zA-Z]+");
  RegExp emailPattern1 = RegExp(r"^[a-zA-Z0-9]{3,64}");
  RegExp emailPattern2 = RegExp(r"[A-Z]{0}[a-z]{3,255}[A-Z]{0}[\.]{1}[a-z]+$");
  RegExp emailPattern3 = RegExp(r"[\.]{1}[a-z]{2,3}$");
  RegExp usernamePattern = RegExp(r"[a-zA-Z0-9\_]{3, 20}");

  addUser(Acct user) {
    _users.add(
      Acct(
          lastName: user.lastName,
          firstName: user.firstName,
          gender: user.gender,
          id: DateTime.now().toString(),
          isAdmin: user.isAdmin,
          password: user.password,
          email: user.email,
          phoneNumber: user.phoneNumber,
          username: user.username),
    );
    notifyListeners();
  }

  List<Acct> accounts() {
    return [..._users];
  }

  loginUser(Acct user) {
    _users.any((element) {
      element.password == user.password && element.username == user.username;
      adminState = element.isAdmin;
      return element.isAdmin;
    });
    if (_users.any((element) =>
        element.username == user.username &&
        element.password == user.password)) {
      loginStatus = true;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  void toggleAdmin(Acct user) {
    user.isAdmin = !user.isAdmin;
    notifyListeners();
  }
}
