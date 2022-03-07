import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/global_variables.dart';

enum AuthMode { signup, login }

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final formKey = GlobalKey<FormState>();
  Map authData = {
    'email': "",
    'password': "",
  };
  AuthMode authMode = AuthMode.login;
  var isLoading = false;
  final passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();
  final confirmpasswordFocusNode = FocusNode();

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });
      if (authMode == AuthMode.login) {
        await Provider.of<Auth>(context, listen: false).signin(
          authData['email'],
          authData['password'],
        );
      } else {
        await Provider.of<Auth>(context, listen: false).signup(
          authData['email'],
          authData['password'],
        );
      }
    } catch (error) {
      ScaffoldMessenger.maybeOf(context)!
          .showSnackBar(snackbarError(error.toString()));
    }
    setState(() {
      isLoading = false;
    });
  }

  void switchAuthMode() {
    if (authMode == AuthMode.login) {
      setState(() {
        authMode = AuthMode.signup;
      });
    } else {
      setState(() {
        authMode = AuthMode.login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 8,
      child: Container(
        constraints:
            BoxConstraints(minHeight: authMode == AuthMode.signup ? 320 : 260),
        width: 400,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
              child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => emailValidator(value),
                autofocus: true,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(passwordFocusNode),
                onSaved: (value) => authData['email'] = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
                obscureText: true,
                focusNode: passwordFocusNode,
                controller: passwordController,
                onFieldSubmitted: (_) {
                  if (authMode == AuthMode.signup) {
                    return FocusScope.of(context)
                        .requestFocus(confirmpasswordFocusNode);
                  } else {
                    submit();
                  }
                },
                validator: (value) => passwordValidator(value),
                onSaved: (value) => authData['password'] = value,
              ),
              if (authMode == AuthMode.signup)
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: "Confirm Password"),
                  obscureText: true,
                  focusNode: confirmpasswordFocusNode,
                  validator: (value) {
                    passwordValidator(value);
                    if (value != passwordController.text) {
                      return "Passwords don't match";
                    } else {
                      return null;
                    }
                  },
                  onFieldSubmitted: (_)=>submit(),
                  onSaved: (_) =>
                      authData['password'] = passwordController.text,
                ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextButton(
                      onPressed: switchAuthMode,
                      child: Text(authMode != AuthMode.login
                          ? "Switch to login"
                          : "Switch to sign Up"),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 8),
                      ),
                    ),
                  ),
                  const Expanded(flex: 1, child: SizedBox()),
                  Flexible(
                    flex: 2,
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: submit,
                            child: Text(authMode == AuthMode.login
                                ? 'Login'
                                : "Sign Up"),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 30,
                              ),
                            ),
                          ),
                  )
                ],
              ),
            ],
          )),
        ),
      ),
    );
  }
}
