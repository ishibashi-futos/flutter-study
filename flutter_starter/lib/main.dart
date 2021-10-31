import 'package:flutter/material.dart';
import 'package:flutter_starter/view_password.dart';
import 'package:flutter_starter/edit_password.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now().toString();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Keycloak: $now'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Password> passwords = [
    Password(
        site: 'www.google.co.jp',
        id: 'hogehoge@gmail.com',
        password: 'password123'),
    Password(
        site: 'app.asana.com',
        id: 'hogehoge@gmail.com',
        password: 'password123+asana'),
    Password(
        site: 'www.amazon.co.jp',
        id: 'hogehoge@gmail.com',
        password: 'password123+amazon'),
  ];

  void editItem(Password newPassword) {
    // TODO: 今の実装方法では、サイトURLが変更された場合別サイトとして登録されてしまう(バグ)
    final hasOldPassword = passwords.firstWhere(
        (element) => element.site == newPassword.site,
        orElse: () => const Password(site: '', id: '', password: ''));
    if (hasOldPassword.site == '') {
      passwords.add(newPassword);
    } else {
      passwords = passwords.map((p) {
        return newPassword.site == p.site ? newPassword : p;
      }).toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        // AppBarのタイトルを中央寄せにする
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int i) {
          // 複数のWidgetをまとめて使いたいときはColumn Widgetを使用する
          final title = passwords[i].site;
          return Column(
            children: [
              ListTile(
                onTap: () {
                  // 画面遷移処理の記述
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewPasswordPage(
                              password: passwords[i], editPassword: editItem)));
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
        itemCount: passwords.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditPasswordPage(
                        password: Password.newBlankPassword(),
                        saveAction: editItem,
                      )));
        },
        tooltip: 'Add password item',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Password {
  final String site;
  final String id;
  final String password;
  const Password(
      {required this.site, required this.id, required this.password});
  @override
  String toString() {
    return '{"site": "$site", "id": "$id", "password": "$password"}';
  }

  static Password newBlankPassword() {
    return const Password(site: '', id: '', password: '');
  }
}
