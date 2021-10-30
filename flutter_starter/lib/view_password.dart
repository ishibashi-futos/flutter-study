import 'package:flutter/material.dart';
import 'package:flutter_starter/edit_password.dart';
import 'package:flutter_starter/main.dart';
import 'package:flutter/services.dart';

class ViewPasswordPage extends StatefulWidget {
  final Password password;
  final EditPassword editPassword;
  const ViewPasswordPage({Key? key, required this.password, required this.editPassword,}) : super(key: key);
  @override
  _ViewPasswordState createState() => _ViewPasswordState();
}

class _ViewPasswordState extends State<ViewPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.password.site)),
      body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(width: 100, child: Text('ID')),
                  const Text(':'),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(widget.password.id))
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(5),
              ),
              Row(
                children: [
                  const SizedBox(width: 100, child: Text('Password')),
                  const Text(':'),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(widget.password.password.length > 15
                                ? widget.password.password.substring(0, 10) +
                                    '...'
                                : widget.password.password),
                          ),
                          // パスワードのコピーボタンを実装
                          IconButton(
                            icon: const Icon(Icons.copy),
                            onPressed: () async {
                              final data =
                                  ClipboardData(text: widget.password.password);
                              await Clipboard.setData(data);
                              // パスワードのコピーに成功した場合、SnackBarという画面下部の通知エリアに通知を2秒間だけ表示する
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Password Clipped!'),
                                duration: Duration(seconds: 2),
                              ));
                            },
                          ),
                        ],
                      )),
                ],
              )
            ],
          )),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Edit item',
        child: const Icon(Icons.create),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EditPasswordPage(password: widget.password, saveAction: widget.editPassword,)));
        },
      ),
    );
  }
}
