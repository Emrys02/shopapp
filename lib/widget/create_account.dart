import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/accounts.dart';
import 'package:shopapp/providers/global_variables.dart';

class CreateAccount extends StatefulWidget {
  static const route = "CreateaccountPage";

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final formData = GlobalKey<FormState>();
  final lastnameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final usernameFocusNode = FocusNode();
  final genderFocusNode = FocusNode();
  final phoneNumberFocusNode = FocusNode();

  var acctdetails = Acct(
    firstName: "",
    email: "",
    lastName: "",
    id: "",
    password: "",
    username: "",
    gender: "",
    isAdmin: false,
    phoneNumber: 0,
  );
  @override
  void dispose() {
    lastnameFocusNode.removeListener(() {});
    emailFocusNode.removeListener(() {});
    genderFocusNode.removeListener(() {});
    passwordFocusNode.removeListener(() {});
    usernameFocusNode.removeListener(() {});
    phoneNumberFocusNode.removeListener(() {});

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var acctSettings = Provider.of<AcctDetails>(context);

    void save() {
      if (formData.currentState!.validate()) {
        formData.currentState!.save();
        acctSettings.addUser(acctdetails);
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarGood("Account Successfully Created"),
        );
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          snackbarError(
              "Save Error, make sure valid information is entered into all fields"),
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
                placeholder: Global.loadingImage,
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
                        inputFormatters: nameInputFilters,
                        decoration: const InputDecoration(
                            labelText: "Surname",
                            hintText: "First letter must be in caps",
                            helperText:
                                "Only the first character should be in UpperCase",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10)),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLength: 30,
                        autofocus: true,
                        onFieldSubmitted: (_) => FocusScope.of(context)
                            .requestFocus(lastnameFocusNode),
                        onSaved: (value) {
                          acctdetails.lastName = value!;
                        },
                        validator: (value) => nameValidator(value),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        inputFormatters: nameInputFilters,
                        decoration: const InputDecoration(
                            labelText: "Lastname",
                            hintText: "First letter must be in caps",
                            helperText:
                                "Only the first character should be in UpperCase",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10)),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLength: 30,
                        focusNode: lastnameFocusNode,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(emailFocusNode),
                        onSaved: (value) {
                          acctdetails.firstName = value!;
                        },
                        validator: (value) => nameValidator(value),
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
                        inputFormatters: emailInputFilters,
                        focusNode: emailFocusNode,
                        onFieldSubmitted: (_) => FocusScope.of(context)
                            .requestFocus(usernameFocusNode),
                        onSaved: (value) {
                          acctdetails.email = value!;
                        },
                        validator: (value) => emailValidator(value),
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
                        inputFormatters: userNameFilters,
                        onSaved: (value) {
                          acctdetails.username = value!;
                        },
                        onFieldSubmitted: (_) => FocusScope.of(context)
                            .requestFocus(passwordFocusNode),
                        focusNode: usernameFocusNode,
                        validator: (value) => nameValidator(value),
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
                        inputFormatters: passwordInputFilter,
                        obscuringCharacter: "*",
                        onChanged: (value) {
                          acctdetails.password = value;
                        },
                        onSaved: (value) {
                          acctdetails.password = value!;
                        },
                        focusNode: passwordFocusNode,
                        validator: (value) => passwordValidator(value),
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
                        onFieldSubmitted: (_) => FocusScope.of(context)
                            .requestFocus(phoneNumberFocusNode),
                        obscuringCharacter: "*",
                        inputFormatters: passwordInputFilter,
                        onSaved: (value) {
                          acctdetails.password = value!;
                        },
                        validator: (value) => passwordValidator(value),
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
                        inputFormatters: phoneNumberInputFilter,
                        onSaved: (value) {
                          acctdetails.phoneNumber = int.parse(value!);
                        },
                        focusNode: phoneNumberFocusNode,
                        onFieldSubmitted: (_) => FocusScope.of(context)
                            .requestFocus(genderFocusNode),
                        validator: (value) => phoneNumberValidator(value),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: DropdownButtonFormField(
                        focusNode: genderFocusNode,
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
                            acctdetails.gender = "male";
                          }
                          if (value == GenderOptions.female) {
                            acctdetails.gender = "female";
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
