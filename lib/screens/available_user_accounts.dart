import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/accounts.dart';
import 'package:shopapp/providers/global_variables.dart';
import 'package:shopapp/widget/create_account.dart';

import '../widget/nav_menu.dart';

class UserAccounts extends StatelessWidget {
  static const route = "Registered Accounts";

  @override
  Widget build(BuildContext context) {
    var details = Provider.of<AcctDetails>(context);
    List<Acct> account = details.accounts();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registered Accounts"),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, CreateAccount.route),
              icon: const Icon(Icons.add_rounded)),
          NavMenu()
        ],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            Provider.of<AcctDetails>(context, listen: false).retrieveUsers(),
        child: ListView.builder(
          itemCount: account.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(account[index].username),
            subtitle:
                Text("${account[index].firstName} ${account[index].lastName}"),
            trailing: IconButton(
              onPressed: () {
                details.toggleAdmin(account[index]);

                ScaffoldMessenger.of(context).showSnackBar(
                    snackBarGood("Admin status has been changed successfully"));
              },
              icon: account[index].isAdmin
                  ? const Icon(Icons.supervisor_account_rounded)
                  : const Icon(Icons.account_circle_rounded),
            ),
          ),
        ),
      ),
    );
  }
}
