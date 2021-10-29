import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'Keycloak'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        // AppBarのタイトルを中央寄せにする
        centerTitle: true,
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.vpn_key),
            title: Text('www.google.com'),
          ),
          ListTile(
            leading: Icon(Icons.vpn_key),
            title: Text('app.asana.com'),
          ),
          ListTile(
            leading: Icon(Icons.vpn_key),
            title: Text('amazon.co.jp'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// TODO: リストを表示
// TODO: リスト間に区切り線を表示
// TODO: リスト表示を動的に
// TODO: フローとアクションボタンをタップ時に、リストを1つ追加
// TODO: 新しい画面を作成し、リストをタップしたときに遷移
// TODO: 新しい画面のレイアウト作成
// TODO: 新しい画面にリストからデータを引き継ぐ
