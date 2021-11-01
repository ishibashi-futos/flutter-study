import 'package:flutter/material.dart';

typedef LoginAction = Future<void> Function();

class Login extends StatelessWidget {
  final LoginAction loginAction;
  final String loginError;

  const Login({required this.loginAction, required this.loginError});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
            onPressed: () {
              loginAction();
            },
            child: const Text('Login')),
        Text(loginError),
      ],
    );
  }
}
