import 'package:flutter/material.dart';

import '../widget/auth_card.dart';

class AuthScreen extends StatelessWidget {
  static String route = "auth screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.grey.shade600,
                  Colors.green.shade500,
                  Colors.grey.shade500
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned(
            bottom: 200,
            child: SingleChildScrollView(
              child:  Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const[
                    Flexible(
                      flex: 2,
                      child: AuthCard(),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}