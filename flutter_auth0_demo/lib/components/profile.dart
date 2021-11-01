import 'package:flutter/material.dart';

typedef LogoutAction = Future<void> Function();

class Profile extends StatelessWidget {
  final LogoutAction logoutAction;
  final String name;
  final String picture;

  Profile(
      {Key? key,
      required this.logoutAction,
      required this.name,
      required this.picture});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 4.0),
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(picture),
              )),
        ),
        const SizedBox(height: 48.0),
        Text('Name: $name'),
        const SizedBox(height: 48.0),
        // サンプルだとRaisedButtonになっているが。非推奨になっているので推奨のものを使用
        // https://zenn.dev/sugitlab/articles/772e107b515908
        ElevatedButton(
            onPressed: () {
              logoutAction();
            },
            child: const Text('Logout'))
      ],
    );
  }
}
