import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class AsanaAppAuth {
  final Uri authorizationEndpoint;
  final Uri tokenEndpoint;
  final String clientId;
  final String clientSecret;
  final int redirectServerPort;
  final StreamController<String> _controller = StreamController();
  AsanaAppAuth(this.authorizationEndpoint, this.tokenEndpoint, this.clientId,
      this.clientSecret,
      {this.redirectServerPort = 8080});

  HttpServer? server;

  Future<String> get code => _controller.stream.first;

  Future<TokenResponse> get token async {
    final tokenCode = await code;
    print('code: $tokenCode');
    final response = await http.post(tokenEndpoint, body: {
      'grant_type': 'authorization_code',
      'client_id': clientId,
      'client_secret': clientSecret,
      'redirect_uri': 'http://localhost:8080/',
      'code': tokenCode
    });
    return TokenResponse.fromMap(json.decode(response.body));
  }

  start() async {
    server = await HttpServer.bind(
        InternetAddress.loopbackIPv4, redirectServerPort,
        shared: true);
    server!.listen((request) async {
      final uri = request.uri;
      print(uri.toString());
      request.response
        ..statusCode = 200
        ..headers.set('Content-Type', ContentType.html.mimeType)
        ..write('Hello, World!');
      await request.response.close();
      final code = uri.queryParameters['code'];
      final error = uri.queryParameters['error'];
      if (code != null) {
        _controller.add(code);
      } else if (error != null) {
        _controller.add('');
        _controller.addError(error);
      }
    });
  }

  stop() async {
    await server!.close(force: true);
  }
}

class TokenResponse {
  final String accessToken;
  final int expiresIn;
  final TokenUserResponse data;
  final String refreshToken;
  TokenResponse(this.accessToken, this.expiresIn, this.data, this.refreshToken);
  static TokenResponse fromMap(Map<String, dynamic> map) {
    final data = map['data'];
    return TokenResponse(
        map['access_token'],
        map['expires_in'],
        TokenUserResponse(data['id'], data['gid'], data['name'], data['email']),
        map['refresh_token']);
  }
}

class TokenUserResponse {
  final int id;
  final String gid;
  final String name;
  final String email;
  const TokenUserResponse(this.id, this.gid, this.name, this.email);
}
