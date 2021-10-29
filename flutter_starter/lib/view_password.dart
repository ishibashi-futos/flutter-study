import 'package:flutter/material.dart';
import 'package:flutter_starter/edit_password.dart';
import 'package:flutter_starter/main.dart';

class ViewPasswordPage extends StatefulWidget {
  final Password password;
  const ViewPasswordPage({Key? key, required this.password}) : super(key: key);
  @override
  _ViewPasswordState createState() => _ViewPasswordState();
}

class _ViewPasswordState extends State<ViewPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View Password: ' + widget.password.site)),
      body: Padding(padding: const EdgeInsets.all(30.0),child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [Container(width: 100, child: Text('ID')), Text(':'), Text(widget.password.id)],
          ),
          const Padding(padding: EdgeInsets.all(5),),
          Row(
            children: [Container(width: 100, child: Text('Password')), Text(':'), Text(widget.password.password)],
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Edit item',
        child: const Icon(Icons.create),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EditPasswordPage()));
        },
      ),
    );
  }
}
