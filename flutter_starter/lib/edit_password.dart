import 'package:flutter/material.dart';
import 'package:flutter_starter/create_password.dart';
import 'package:flutter_starter/logger.dart';
import 'package:flutter_starter/repository/password_repository.dart';

class EditPasswordPage extends StatefulWidget {
  final String id;
  final UpdatePassword updatePassword;
  const EditPasswordPage(
      {Key? key, required this.id, required this.updatePassword})
      : super(key: key);

  @override
  _EditPasswordState createState() => _EditPasswordState();
}

typedef UpdatePassword = void Function(String id, Password password);

class _EditPasswordState extends State<EditPasswordPage> {
  late TextEditingController _textEditingControllerWithSite;
  late TextEditingController _textEditingControllerWithId;
  late TextEditingController _textEditingControllerWithPassword;
  late String _site;
  late String _id;
  late String _password;
  bool _isObscure = true;
  static final Logger _logger = Logger();
  final _repository = PasswordRepository();

  void _handleTextSite(String s) {
    _logger.info('site changed: $s');
    setState(() {
      _site = s;
    });
  }

  void _handleTextId(String s) {
    _logger.info('id changed: $s');
    setState(() {
      _id = s;
    });
  }

  void _handleTextPassword(String s) {
    _logger.info('password changed: $s');
    setState(() {
      _password = s;
    });
  }

  @override
  void initState() {
    super.initState();
    var password = _repository.findId(widget.id);
    password ??= Password.newBlankPassword();
    _textEditingControllerWithSite = TextEditingController(text: password.site);
    _textEditingControllerWithId = TextEditingController(text: password.id);
    _textEditingControllerWithPassword =
        TextEditingController(text: password.password);
    setState(() {
      _site = password!.site;
      _id = password.id;
      _password = password.password;
    });
  }

  @override
  void dispose() {
    // リソースの開放処理を明示的に呼び出す.
    _textEditingControllerWithSite.dispose();
    _textEditingControllerWithId.dispose();
    _textEditingControllerWithPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Password'),
        actions: <Widget>[
          PopupMenuButton<Choice>(
            onSelected: (Choice choice) {
              if (choice.title == '自動生成') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateNewPassword())).then(
                    (value) => _textEditingControllerWithPassword.text = value);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<Choice>(
                  value: Choice(title: '自動生成', icon: Icons.create),
                  child: Text('自動生成'),
                )
              ];
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              enabled: true,
              maxLength: 255,
              obscureText: false,
              maxLines: 1,
              decoration: const InputDecoration(
                  icon: Icon(Icons.web),
                  hintText: 'Site URL',
                  labelText: 'Site URL'),
              controller: _textEditingControllerWithSite,
              onChanged: _handleTextSite,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              enabled: true,
              maxLength: 255,
              obscureText: false,
              maxLines: 1,
              decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Site ID',
                  labelText: 'Site ID'),
              controller: _textEditingControllerWithId,
              onChanged: _handleTextId,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              enabled: true,
              maxLength: 255,
              obscureText: _isObscure,
              maxLines: 1,
              decoration: InputDecoration(
                  icon: const Icon(Icons.vpn_key),
                  hintText: 'Site Password',
                  labelText: 'Site Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                        _isObscure ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  )),
              controller: _textEditingControllerWithPassword,
              onChanged: _handleTextPassword,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final password = Password(site: _site, id: _id, password: _password);
          _logger.info(password.toString());
          widget.updatePassword(widget.id, password);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}

class Choice {
  final String title;
  final IconData icon;
  const Choice({required this.title, required this.icon});
}
