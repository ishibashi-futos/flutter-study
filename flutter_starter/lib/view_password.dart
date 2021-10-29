import 'package:flutter/material.dart';
import 'package:flutter_starter/edit_password.dart';

class ViewPasswordPage extends StatefulWidget {
  @override
  _ViewPasswordState createState()  => _ViewPasswordState();
}

class _ViewPasswordState extends State<ViewPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: const Text('View Password')
    ),
    floatingActionButton: FloatingActionButton(
      tooltip: 'Edit item',
      child: const Icon(Icons.create),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => EditPasswordPage()));
      },
    ),);
  }
}