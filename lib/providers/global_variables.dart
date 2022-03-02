import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum FilterOptions {
  account,
  home,
  favourites,
  cart,
  checkout,
}

enum GenderOptions {
  male,
  female,
}

class Global {
  static const loadingImage = "assets/images/loading.gif";
  static const emptyImage = "assets/images/empty.gif";
}

List<FilteringTextInputFormatter> nameInputFilters = [
  FilteringTextInputFormatter.allow(
    RegExp(r"[A-Za-z]"),
  ),
  FilteringTextInputFormatter.deny(
    RegExp(r"^[a-z]"),
  ),
  FilteringTextInputFormatter.deny(
    RegExp(r"^[A-Z]{1}[A-Z]"),
  ),
  FilteringTextInputFormatter.deny(
    RegExp(r"[a-z]+[A-Z]"),
  ),
];

List<FilteringTextInputFormatter> userNameFilters = [
  FilteringTextInputFormatter.allow(
    RegExp(r"[a-zA-Z0-9\_\.]"),
  ),
];

List<FilteringTextInputFormatter> emailInputFilters = [
  FilteringTextInputFormatter.allow(
    RegExp(r"[a-zA-Z0-9\@\.]"),
  )
];

List<FilteringTextInputFormatter> passwordInputFilter = [
  FilteringTextInputFormatter.allow(
    RegExp(r"[a-zA-Z0-9@_#$]"),
  ),
];

List<FilteringTextInputFormatter> phoneNumberInputFilter = [
  FilteringTextInputFormatter.allow(
    RegExp(r"[0-9]"),
  ),
];

String? nameValidator(value) {
  if (value!.isEmpty) {
    return "Please enter your surname";
  }
  if (value.length > 20) {
    return "Sorry maximum name length is 30";
  }
  if (value.length < 3) {
    return "Sorry minimum name length is 3";
  }
  return null;
}

String? emailValidator(value) {
  if (value!.isEmpty) {
    return "Please enter your email";
  }
  if (!value.contains(RegExp(r"^[a-zA-Z0-9]{3,64}"))) {
    return "Please enter a valid email address";
  }
  if (!value.contains(RegExp(r"[A-Z]{0}[a-z]{3,255}[A-Z]{0}[\.]{1}[a-z]+$"))) {
    return "Please enter a valid email address";
  }
  if (!value.contains(RegExp(r"[\.]{1}[a-z]{2,3}$"))) {
    return "Please enter a valid email address";
  }
  return null;
}

String? passwordValidator(value) {
  if (value!.isEmpty) {
    return "Please enter your password";
  }
  if (!value.contains(RegExp(r"[a-z]"))) {
    return "Invalid password format";
  }
  if (!value.contains(RegExp(r"[A-Z]"))) {
    return "Invalid password format";
  }
  if (!value.contains(RegExp(r"[0-9]"))) {
    return "Invalid password format";
  }
  return null;
}

String? phoneNumberValidator(value) {
  if (value!.isEmpty) {
    return "Please enter your phone number";
  }
  if (value.length < 11) {
    return "Invalid phone number";
  }
  if (!value.contains(RegExp(r"0[8|9][0|1][0-9]{8}")) &&
      !value.contains(RegExp(r"070[0-9]{8}"))) {
    return "Unsupported mobile number format";
  }
  return null;
}

SnackBar snackbarError(String text) {
  return SnackBar(
    content: Text(text),
    backgroundColor: Colors.red,
    behavior: SnackBarBehavior.floating,
    dismissDirection: DismissDirection.horizontal,
    margin: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
  );
}

SnackBar snackBarGood(String text) {
  return SnackBar(content: Text(text),
    backgroundColor: Colors.green,
    behavior: SnackBarBehavior.floating,
    dismissDirection: DismissDirection.horizontal,
    margin: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
  );
}
