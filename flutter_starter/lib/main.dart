import 'package:flutter/material.dart';

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
  List<String> titleList = ['www.google.co.jp', 'app.asana.com', 'www.amazon.co.jp'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        // AppBarのタイトルを中央寄せにする
        centerTitle: true,
      ),
      body: ListView.builder(itemBuilder: (BuildContext context, int i) {
        // 複数のWidgetをまとめて使いたいときはColumn Widgetを使用する
        return Column(
          children: [
            ListTile(
              leading: const Icon(Icons.vpn_key),
              title: Text(titleList[i]),
            ),
            const Divider(thickness: 1.25,)
          ],
        );
        // ListBuilderContextの実行回数はitemCountで決定できる
      }, itemCount: titleList.length,),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ボタンが押された時の処理
          titleList.add(DateTime.now().toString());
          setState(() {
            // void
          });
        },
        tooltip: 'Add password item',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// TODO: フローとアクションボタンをタップ時に、リストを1つ追加
// TODO: 新しい画面を作成し、リストをタップしたときに遷移
// TODO: 新しい画面のレイアウト作成
// TODO: 新しい画面にリストからデータを引き継ぐ
