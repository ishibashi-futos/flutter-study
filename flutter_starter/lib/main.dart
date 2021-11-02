import 'package:flutter/material.dart';
import 'package:flutter_starter/logger.dart';
import 'package:flutter_starter/view_password.dart';
import 'package:flutter_starter/edit_password.dart';
import 'package:flutter_starter/repository/password_repository.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class KeyValuePair<K, V> {
  final K key;
  final V value;
  const KeyValuePair({required this.key, required this.value});
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final Logger _logger = Logger();
  List<KeyValuePair<String, Password>> _passwords =
      PasswordRepository().findAll().entries.map((e) {
    return KeyValuePair<String, Password>(key: e.key, value: e.value);
  }).toList();
  String _title = 'Keycloak: ${DateTime.now().toString()}';

  void _updatePassword(String id, Password password) {
    _logger.info('update state');
    setState(() {
      var repository = PasswordRepository();
      repository.update(id, password);
      _passwords = repository.findAll().entries.map((e) {
        return KeyValuePair<String, Password>(key: e.key, value: e.value);
      }).toList();
      final now = DateTime.now().toString();
      _title = 'Keycloak: $now';
    });
    // 最後は必ずホームに戻る
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MyHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        // AppBarのタイトルを中央寄せにする
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int i) {
          // 複数のWidgetをまとめて使いたいときはColumn Widgetを使用する
          final title = _passwords[i].value.site;
          return Column(
            children: [
              ListTile(
                onTap: () {
                  // 画面遷移処理の記述
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewPasswordPage(
                                passwordId: _passwords[i].key,
                                updatePassword: _updatePassword,
                              )));
                },
                leading: const Icon(Icons.vpn_key),
                title: Text(title),
              ),
              const Divider(
                thickness: 1.25,
              )
            ],
          );
          // ListBuilderContextの実行回数はitemCountで決定できる
        },
        itemCount: _passwords.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditPasswordPage(
                        id: const Uuid().v4(),
                        updatePassword: _updatePassword,
                      )));
        },
        tooltip: 'Add password item',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
