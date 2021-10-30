import 'package:flutter/material.dart';
import 'package:flutter_starter/main.dart';

typedef EditPassword = void Function(Password);

class EditPasswordPage extends StatefulWidget {
  final Password password;
  final EditPassword saveAction;
  const EditPasswordPage({Key? key, required this.password, required this.saveAction}) : super(key: key);

  @override
  _EditPasswordState createState()  => _EditPasswordState();
}

class _EditPasswordState extends State<EditPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: const Text('Edit Password')
    ),floatingActionButton: FloatingActionButton(
      onPressed: () {
        widget.saveAction(const Password(site: 'modified.com', id: 'modified@modified.co.jp', password: 'modified'));
      },
      child: const Icon(Icons.save),
    ),);
  }
}