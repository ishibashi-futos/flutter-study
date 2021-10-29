import 'package:flutter/material.dart';

class EditPasswordPage extends StatefulWidget {
  @override
  _EditPasswordState createState()  => _EditPasswordState();
}

class _EditPasswordState extends State<EditPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: const Text('Edit Password')
    ),);
  }
}