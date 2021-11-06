import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_starter/logger.dart';
import 'dart:math';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({Key? key}) : super(key: key);
  @override
  _CreateNewPasswordState createState() => _CreateNewPasswordState();
}

class _PasswordLetters {
  static const String alphabet = "abcdefghijklmnopqrstuvwxyz";
  static const String ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  static const String numbers = "0123456789";
  static const String symbols = "!@#\$%&_+-=|<>";
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  bool _enableAndNumber = true;
  bool _enableSymbol = true;
  int _length = 8;
  static final Logger _logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Password'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: SwitchListTile(
                title: const Text('英数字'),
                subtitle: const Text('パスワードに[A-Z|a-z|0-9]を使用します'),
                secondary: const Text('Aa9'),
                activeColor: Colors.orange,
                inactiveThumbColor: Colors.grey,
                value: _enableAndNumber,
                onChanged: (bool e) {
                  _logger.info('_enableAndNumber: $e');
                  setState(() {
                    _enableAndNumber = e;
                  });
                }),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: SwitchListTile(
                title: const Text('Symbol'),
                subtitle: const Text('パスワードに[!@#\$%&_+-=|<>]を使用します'),
                secondary: const Text('@'),
                activeColor: Colors.orange,
                inactiveThumbColor: Colors.grey,
                value: _enableSymbol,
                onChanged: (bool e) {
                  _logger.info('_enableSymbol: $e');
                  setState(() {
                    _enableSymbol = e;
                  });
                }),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              enabled: true,
              maxLength: 3,
              obscureText: false,
              maxLines: 1,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  icon: Icon(Icons.web),
                  hintText: '1-255',
                  labelText: 'Password Length'),
              onChanged: (value) {
                if (value == "") {
                  return;
                }
                setState(() {
                  try {
                    var parsed = int.parse(value);
                    if (parsed > 255) {
                      _length = 255;
                    } else if (parsed <= 0) {
                      _length = 0;
                    } else {
                      _length = int.parse(value);
                    }
                    _logger.info('_length: $_length');
                  } catch (e, s) {
                    _logger.error('数値への変換に失敗しました', e);
                  }
                });
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var letters = StringBuffer();
          letters.write(_enableAndNumber
              ? _PasswordLetters.alphabet +
                  _PasswordLetters.ALPHABET +
                  _PasswordLetters.numbers
              : "");
          letters.write(_enableSymbol ? _PasswordLetters.symbols : "");
          var string = letters.toString();
          _logger.info('letters: $string');
          var password = _createPassword(_length, string);
          _logger.info('p: $password');
          Navigator.pop(context, password);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}

String _createPassword(int length, String letters) {
  if (length <= 0 || letters.isEmpty) {
    return "";
  }
  final logger = Logger();
  final shuffleLetters = letters.split("");
  shuffleLetters.shuffle();
  final shuffledLetters = shuffleLetters.join("");
  logger.debug('shuffled letters: $shuffledLetters');
  var buffer = StringBuffer();
  var rng = Random();
  for (var i = 0; i < length; i++) {
    buffer.write(shuffledLetters[rng.nextInt(letters.length - 1)]);
  }
  // TODO: パスワード生成が成功した後、lettersに必要な文字列が含まれているか（例えば、記号が含まれているかどうか）が分からないため修正が必要
  return buffer.toString();
}
