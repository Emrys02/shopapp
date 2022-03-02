import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/accounts.dart';
import '../providers/global_variables.dart';
import '../screens/profile.dart';
import 'create_account.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
  bool retrieve = false;
}

class _LoginState extends State<Login> {
  @override
  void didChangeDependencies() async {
    if (!widget.retrieve) {
      try {
        await Provider.of<AcctDetails>(context, listen: false).retrieveUsers();
      } catch (error) {
        print(error);
      }finally{
        widget.retrieve = true;
        print(Provider.of<AcctDetails>(context, listen: false).accounts());
      }
    }
    super.didChangeDependencies();
  }

  final passwordFocusNode = FocusNode();
  final formData = GlobalKey<FormState>();
  var acctdetails = Acct(
      id: "",
      email: "",
      firstName: "",
      lastName: "",
      password: "",
      username: "",
      gender: "",
      isAdmin: false,
      phoneNumber: 0);
  // Acct userDetails = Acct(
  //   id, password,
  //   username: ,
  //   age: 0,
  //   gender: "",
  //   isAdmin: false,
  //   phoneNumber: 0,
  // );

  @override
  void dispose() {
    passwordFocusNode.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var temp = Provider.of<AcctDetails>(context, listen: false);
    void save() {
      formData.currentState?.save();
      if (temp.loginUser(acctdetails)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Successfully Signed In"),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.only(
              right: 15,
              left: 15,
              bottom: 10,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
        Navigator.of(context).pushReplacementNamed(Profile.route);
      } else {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Username Or Password Is Wrong"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          margin: const EdgeInsets.only(top: 50),
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(passwordFocusNode),
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                        hintText: 'Your Username'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Username field cannot be empty";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      acctdetails = Acct(
                          email: "",
                          firstName: "",
                          lastName: "",
                          gender: "",
                          id: "",
                          isAdmin: false,
                          password: "",
                          phoneNumber: 0,
                          username: value!);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    focusNode: passwordFocusNode,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter your secure password',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password field cannot be empty";
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) => save(),
                    onSaved: (value) {
                      acctdetails = Acct(
                          email: "",
                          firstName: "",
                          lastName: "",
                          id: acctdetails.id,
                          password: value!,
                          username: acctdetails.username,
                          gender: acctdetails.gender,
                          isAdmin: acctdetails.isAdmin,
                          phoneNumber: acctdetails.phoneNumber);
                    },
                  ),
                )
              ],
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(CreateAccount.route),
              child: const Text(
                'Create An Account',
                style: TextStyle(fontSize: 15),
              ),
            ),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        const Text("Sorry this action is not yet available."),
                    backgroundColor: Theme.of(context).errorColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    duration: const Duration(seconds: 2),
                    margin:
                        const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text(
                'Forgot Password',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 12,
              ),
              side: BorderSide(
                style: BorderStyle.solid,
                width: 0.4,
                color: Colors.green.shade300,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () {
            save();
          },
          child: const Text(
            "Confirm",
            style: TextStyle(
              fontSize: 22,
            ),
          ),
        )
      ],
    );
  }
}
