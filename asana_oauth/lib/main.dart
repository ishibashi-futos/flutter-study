import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:asana_oauth/middleware/auth.dart';
import 'package:asana_oauth/asana.dart';

final authorizationEndpoint =
    Uri.parse('https://app.asana.com/-/oauth_authorize');
final tokenEndpoint = Uri.parse('https://app.asana.com/-/oauth_token');
final revokeTokenEndpoint = Uri.parse('https://app.asana.com/-/oauth_revoke');
const cliendId = '【Client Id】';
const clientSecret = '【Client Secret】';
final redirectUrl = Uri.parse('http://localhost:8080/');
Uri? responseUrl;
HttpServer? server;

Future<void> main() async {
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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String token = 'default';
  bool _isBusy = false;
  bool logined = false;
  Response<MeResponse>? response;

  void auth() async {
    final auth = AsanaAppAuth(
        authorizationEndpoint, tokenEndpoint, cliendId, clientSecret);
    await auth.start();
    setState(() {
      _isBusy = true;
    });
    final code = await auth.token;
    print(code);
    final me = await Me.me(code.accessToken);
    setState(() {
      _isBusy = false;
      response = me;
      logined = true;
    });
    await auth.stop();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: _isBusy
            ? const WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl:
                    'https://app.asana.com/-/oauth_authorize?response_type=code&client_id=【ClientId】&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2F',
              )
            : logined
                ? Column(
                    children: [
                      Image.network(response!.data.photo['image_128x128'])
                    ],
                  )
                : Text(token),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          auth();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
