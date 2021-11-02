import 'package:flutter/material.dart';
import 'package:flutter_starter/edit_password.dart';
import 'package:flutter/services.dart';
import 'package:flutter_starter/repository/password_repository.dart';

class ViewPasswordPage extends StatelessWidget {
  final String passwordId;
  final UpdatePassword updatePassword;
  const ViewPasswordPage({
    Key? key,
    required this.passwordId,
    required this.updatePassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _password = PasswordRepository().findId(passwordId);
    return Scaffold(
      appBar: AppBar(title: Text(_password!.site)),
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
                      child: Text(_password.id))
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
                            child: Text(_repeatString(
                                    '●',
                                    _password.password.length > 15
                                        ? 15
                                        : _password.password.length) +
                                (_password.password.length > 15 ? '...' : '')),
                          ),
                          // パスワードのコピーボタンを実装
                          IconButton(
                            icon: const Icon(Icons.copy),
                            onPressed: () async {
                              final data =
                                  ClipboardData(text: _password.password);
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditPasswordPage(
                        id: passwordId,
                        updatePassword: updatePassword,
                      )));
        },
      ),
    );
  }
}

String _repeatString(String s, int length) {
  var buffer = StringBuffer();
  for (var i = 0; i < length; i++) {
    buffer.write(s);
  }
  return buffer.toString();
}
