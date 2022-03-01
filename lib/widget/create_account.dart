import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/accounts.dart';
import 'package:shopapp/providers/global_variables.dart';

class CreateAccount extends StatelessWidget {
  static const route = "CreateaccountPage";
  final formData = GlobalKey<FormState>();
  late var acctdetails = Acct(
      firstName: "",
      email: "",
      lastName: "",
      id: "",
      password: "",
      username: "",
      gender: "",
      isAdmin: false,
      phoneNumber: 0);
  @override
  Widget build(BuildContext context) {
    var acctSettings = Provider.of<AcctDetails>(context);

    void save() {
      if (formData.currentState!.validate()) {
        formData.currentState!.save();
        acctSettings.addUser(acctdetails);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Account Successfully Created"),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.horizontal,
            margin: EdgeInsets.only(bottom: 20, left: 15, right: 15),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
                "Save Error, make sure valid information is entered into all fields"),
            backgroundColor: Theme.of(context).errorColor,
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.horizontal,
            margin: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create An Account"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
              ),
              child: FadeInImage.assetNetwork(
                placeholder: "images/loading.gif",
                image:
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png",
              ),
            ),
            Form(
              key: formData,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 30,
                  left: 30,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        inputFormatters: [
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
                        ],
                        decoration: const InputDecoration(
                            labelText: "Surname",
                            hintText: "First letter must be in caps",
                            helperText:
                                "Only the first character should be in UpperCase",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10)),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLength: 30,
                        onSaved: (value) {
                          acctdetails = Acct(
                            email: "",
                            firstName: value!,
                            lastName: "",
                            id: acctdetails.id,
                            password: acctdetails.password,
                            username: acctdetails.username,
                            gender: acctdetails.gender,
                            isAdmin: acctdetails.isAdmin,
                            phoneNumber: acctdetails.phoneNumber,
                          );
                        },
                        validator: (value) {
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
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        inputFormatters: [
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
                        ],
                        decoration: const InputDecoration(
                            labelText: "Lastname",
                            hintText: "First letter must be in caps",
                            helperText:
                                "Only the first character should be in UpperCase",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10)),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLength: 30,
                        onSaved: (value) {
                          acctdetails = Acct(
                            email: "",
                            lastName: value!,
                            firstName: acctdetails.firstName,
                            id: acctdetails.id,
                            password: acctdetails.password,
                            username: acctdetails.username,
                            gender: acctdetails.gender,
                            isAdmin: acctdetails.isAdmin,
                            phoneNumber: acctdetails.phoneNumber,
                          );
                        },
                        validator: (value) {
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
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            labelText: "Email",
                            hintText: "example@email.com",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10)),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLength: 64,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r"[a-zA-Z0-9\@\.]"),
                          ),
                        ],
                        onSaved: (value) {
                          acctdetails = Acct(
                            email: value!,
                            firstName: acctdetails.firstName,
                            lastName: "",
                            id: acctdetails.id,
                            password: acctdetails.password,
                            username: acctdetails.username,
                            gender: acctdetails.gender,
                            isAdmin: acctdetails.isAdmin,
                            phoneNumber: acctdetails.phoneNumber,
                          );
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your email";
                          }
                          if (!value.contains(RegExp(r"^[a-zA-Z0-9]{3,64}"))) {
                            return "Please enter a valid email address";
                          }
                          if (!value.contains(RegExp(
                              r"[A-Z]{0}[a-z]{3,255}[A-Z]{0}[\.]{1}[a-z]+$"))) {
                            return "Please enter a valid email address";
                          }
                          if (!value.contains(RegExp(r"[\.]{1}[a-z]{2,3}$"))) {
                            return "Please enter a valid email address";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            labelText: "Username",
                            hintText: "This is what we will call you",
                            helperText:
                                "Underscore(_) and fullstop(.) can also be entered ",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10)),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLength: 30,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r"[a-zA-Z0-9\_\.]"),
                          ),
                        ],
                        onSaved: (value) {
                          acctdetails = Acct(
                            email: "",
                            firstName: acctdetails.firstName,
                            lastName: "",
                            id: acctdetails.id,
                            password: acctdetails.password,
                            username: value!,
                            gender: acctdetails.gender,
                            isAdmin: acctdetails.isAdmin,
                            phoneNumber: acctdetails.phoneNumber,
                          );
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your username";
                          }
                          if (value.length > 20) {
                            return "Sorry maximum name length is 30";
                          }
                          if (value.length < 3) {
                            return "Sorry minimum name length is 3";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            labelText: "Password",
                            hintText: "Must contain a-z, A-Z, 0-9",
                            helperText: "Other characters are also allowed",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10)),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: true,
                        obscuringCharacter: "*",
                        onChanged: (value) {
                          acctdetails = Acct(
                            email: "",
                            id: acctdetails.id,
                            firstName: acctdetails.firstName,
                            lastName: acctdetails.lastName,
                            password: value,
                            username: acctdetails.username,
                            gender: acctdetails.gender,
                            phoneNumber: acctdetails.phoneNumber,
                          );
                        },
                        onSaved: (value) {
                          acctdetails = Acct(
                            email: "",
                            id: acctdetails.id,
                            firstName: acctdetails.firstName,
                            lastName: acctdetails.lastName,
                            password: value!,
                            username: acctdetails.username,
                            gender: acctdetails.gender,
                            phoneNumber: acctdetails.phoneNumber,
                          );
                        },
                        validator: (value) {
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
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            labelText: "Confirm Password",
                            hintText: "Enter password again",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10)),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: true,
                        obscuringCharacter: "*",
                        onSaved: (value) {
                          acctdetails = Acct(
                            email: "",
                            id: acctdetails.id,
                            firstName: acctdetails.firstName,
                            lastName: acctdetails.lastName,
                            password: value!,
                            username: acctdetails.username,
                            gender: acctdetails.gender,
                            phoneNumber: acctdetails.phoneNumber,
                          );
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please confirm your password";
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
                          if (value != acctdetails.password) {
                            return "Passwords don't match";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            labelText: "Phone Number",
                            hintText: "Enter your phone number",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10)),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLength: 11,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r"[0-9]"),
                          ),
                        ],
                        onSaved: (value) {
                          acctdetails = Acct(
                            email: "",
                            id: acctdetails.id,
                            firstName: acctdetails.firstName,
                            lastName: acctdetails.lastName,
                            password: acctdetails.password,
                            username: acctdetails.username,
                            gender: acctdetails.gender,
                            phoneNumber: int.parse(value!),
                          );
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your phone number";
                          }
                          if (value.length < 11) {
                            return "Invalid phone number";
                          }
                          if (!value
                              .contains(RegExp(r"0[7|8|9][0|1][0-9]{8}"))) {
                            return "error";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: DropdownButtonFormField(
                        items: const [
                          DropdownMenuItem(
                              child: Text("Male"), value: GenderOptions.male),
                          DropdownMenuItem(
                            child: Text("Female"),
                            value: GenderOptions.female,
                          )
                        ],
                        onChanged: (value) {
                          if (value == GenderOptions.male) {
                            acctdetails = Acct(
                              email: "",
                              id: acctdetails.id,
                              firstName: acctdetails.firstName,
                              lastName: acctdetails.lastName,
                              password: acctdetails.password,
                              username: acctdetails.username,
                              gender: "male",
                              phoneNumber: acctdetails.phoneNumber,
                            );
                          }
                          if (value == GenderOptions.female) {
                            acctdetails.gender ="";
                          }
                        },
                        hint: const Text("Gender"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            TextButton.icon(
              onPressed: () => save(),
              icon: const Icon(
                Icons.save_rounded,
                size: 30,
              ),
              label: const Text(
                "Save",
                style: TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
