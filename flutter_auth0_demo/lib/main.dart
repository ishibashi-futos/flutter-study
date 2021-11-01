import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_auth0_demo/auth0_variables.dart';

import 'components/profile.dart';
import 'components/login.dart';

final FlutterAppAuth appAuth = FlutterAppAuth();
const FlutterSecureStorage secureStorage = FlutterSecureStorage();

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isBusy = false;
  bool isLoggedIn = false;
  String errorMessage = '';
  String name = '';
  String picture = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Auth0 Demo',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Auth0 Demo'),
          ),
          body: Center(
              child: isBusy
                  ? const CircularProgressIndicator()
                  : isLoggedIn
                      ? Profile(
                          logoutAction: loginAction,
                          name: name,
                          picture: picture,
                        )
                      : Login(
                          loginAction: loginAction, loginError: errorMessage)),
        ));
  }

  Map<String, dynamic> parseIdToken(String idToken) {
    final parts = idToken.split(r'.');
    assert(parts.length == 3);
    return jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
  }

  Future<Map<String, dynamic>> getUserDetails(String accessToken) async {
    final response = await http.get(
      Uri(scheme: 'https', host: Auth0.DOMAIN, path: '/userinfo'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get user details');
    }
  }

  Future<void> loginAction() async {
    setState(() {
      isBusy = true;
      errorMessage = '';
    });

    try {
      final result = await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(Auth0.CLIENT_ID, Auth0.REDIRECT_URI,
            issuer: 'https://${Auth0.DOMAIN}',
            scopes: ['openid', 'profile', 'offline_access'],
            promptValues: ['login']),
      );
      if (result == null) {
        throw ('Result is null');
      }
      final idToken = parseIdToken(result.idToken ?? '');
      final profile = await getUserDetails(result.accessToken ?? '');
      await secureStorage.write(
          key: 'refresh_token', value: result.refreshToken);
      setState(() {
        isBusy = false;
        isLoggedIn = true;
        name = idToken['name'];
        picture = profile['picture'];
      });
    } catch (e, s) {
      print('login error: $e - stack: $s');
      setState(() {
        isBusy = false;
        isLoggedIn = false;
        errorMessage = e.toString();
      });
    }
  }

  void logoutAction() async {
    await secureStorage.delete(key: 'refresh_token');
    setState(() {
      isLoggedIn = false;
      isBusy = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    initAction();
    super.initState();
  }

  void initAction() async {
    final storedRefreshToken = await secureStorage.read(key: 'refresh_token');
    if (storedRefreshToken == null) return;

    setState(() {
      isBusy = true;
    });

    try {
      final response = await appAuth.token(TokenRequest(
          Auth0.CLIENT_ID, Auth0.REDIRECT_URI,
          issuer: Auth0.ISSUER, refreshToken: storedRefreshToken));

      if (response == null) {
        throw ('Result is null');
      }
      final idToken = parseIdToken(response.idToken ?? '');
      final profile = await getUserDetails(response.accessToken ?? '');

      secureStorage.write(key: 'refresh_token', value: response.refreshToken);
      setState(() {
        isBusy = false;
        isLoggedIn = true;
        name = idToken['name'];
        picture = profile['picture'];
      });
    } catch (e, s) {
      print('error on refresh token: $e - stack: $s');
      logoutAction();
    }
  }
}
