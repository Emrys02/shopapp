import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/screens/available_user_accounts.dart';

import '../providers/accounts.dart';
import '../widget/login.dart';
import '../widget/nav_menu.dart';
import 'user_products.dart';

class Profile extends StatelessWidget {
  static const route = "Profilepage";

  @override
  Widget build(BuildContext context) {
    var details = Provider.of<AcctDetails>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page"),
        actions: [NavMenu()],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: !details.loginStatus
          ? const Login()
          : Column(
              children: [
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(UserProducts.route),
                  child: const Text(
                    "View Products",
                  ),
                ),
                TextButton.icon(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(UserAccounts.route),
                    icon: const Icon(Icons.account_tree_rounded),
                    label: const Text("View Users"))
              ],
            ),
    );
  }
}
