import 'dart:convert';

import 'package:http/http.dart' as http;

class Me {
  static Future<Response<MeResponse>> me(String token) async {
    final response = await http.get(
        Uri.parse('https://app.asana.com/api/1.0/users/me'),
        headers: {'Authorization': 'Bearer $token'});
    return MeResponse.fromJson(json.decode(response.body));
  }
}

class Response<T> {
  T data;
  Response(this.data);
}

class MeResponse {
  final String gid;
  final String email;
  final String name;
  final Map<String, dynamic> photo;
  final String resource_type;
  final List<dynamic> workspaces;
  MeResponse(this.gid, this.email, this.name, this.photo, this.resource_type,
      this.workspaces);

  static Response<MeResponse> fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final me = MeResponse(data['gid'], data['email'], data['name'],
        data['photo'], data['resource_type'], data['workspaces']);
    return Response(me);
  }
}
