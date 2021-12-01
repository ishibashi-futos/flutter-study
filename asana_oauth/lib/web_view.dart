import 'package:asana_oauth/main.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AuthorizationWebView extends StatelessWidget {
  final String url;
  const AuthorizationWebView({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl: url,
      navigationDelegate: (navReq) {
        print(navReq.url);
        // responseUrl = Uri.parse(navReq.url);
        return NavigationDecision.navigate;
      },
    );
  }
}
