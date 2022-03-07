import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

class Auth with ChangeNotifier {
  String token = "";
  DateTime? expiryDate;
  String userID = "";

  bool get isAuth {
    return token != "";
  }

  String get authtoken {
    if (expiryDate != null && expiryDate!.isAfter(DateTime.now())) {
      return token;
    }
    return "";
  }

  Future<void> signup(String email, String password) async {
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCnvmbMc651Npm4q6ea2pM3k6xTpsE7XIU");

    try {
      final response = await post(url,
          body: jsonEncode({
            "email": email,
            "password": password,
            "returnSecureToken": true,
          }));
      final responseData = jsonDecode(response.body);
      if (responseData['error'] == null) {
        token = responseData["idToken"];
        userID = responseData["localId"];
        expiryDate = DateTime.now()
            .add(Duration(seconds: int.parse(responseData["expiresIn"])));
        notifyListeners();
      } else {
        throw (responseData['error']['message']);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signin(String email, String password) async {
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCnvmbMc651Npm4q6ea2pM3k6xTpsE7XIU");

    try {
      final response = await post(url,
          body: jsonEncode({
            "email": email,
            "password": password,
            "returnSecureToken": true,
          }));
      final responseData = jsonDecode(response.body);
      if (responseData['error'] == null) {
        token = responseData["idToken"];
        userID = responseData["localId"];
        expiryDate = DateTime.now()
            .add(Duration(seconds: int.parse(responseData["expiresIn"])));
        notifyListeners();
      } else {
        throw (responseData['error']['message']);
      }
    } catch (error) {
      rethrow;
    }
  }
}
