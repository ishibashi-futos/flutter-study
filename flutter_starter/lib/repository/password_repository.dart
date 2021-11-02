import 'package:uuid/uuid.dart';
import 'package:flutter_starter/logger.dart';

var _uuid = const Uuid();

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

class PasswordRepository {
  static final Logger _logger = Logger();
  static Map<String, Password> _passwords = {
    '62615fed-d802-411a-bc76-60aac0bd47e2': const Password(
        site: 'www.google.co.jp',
        id: 'hogehoge@gmail.com',
        password: 'password123'),
    'b9003eb7-dda5-4226-8d4e-e682bc356d49': const Password(
        site: 'app.asana.com',
        id: 'hogehoge@gmail.com',
        password: 'password123+asana'),
    '7446213c-5f66-44ec-848f-ad8193acee76': const Password(
        site: 'www.amazon.co.jp',
        id: 'hogehoge@gmail.com',
        password: 'password123+amazon'),
  };
  static PasswordRepository repository = PasswordRepository.__internal();
  factory PasswordRepository() {
    return PasswordRepository.__internal();
  }
  PasswordRepository.__internal();

  Password? findId(String id) {
    final password = _passwords[id];
    return password;
  }

  Map<String, Password> findAll() {
    return _passwords;
  }

  void update(String id, Password password) {
    _passwords[id] = password;
  }

  String newEntry(Password? password) {
    String uuid = _uuid.v4();
    while(_passwords.containsKey(uuid)) {
      uuid = _uuid.v4();
    }
    update(uuid, password ?? Password.newBlankPassword());
    return uuid;
  }

  void remove(String id) {
    _passwords.remove(id);
  }

  void removeWhere(PasswordRemoveWhere test) {
    _passwords.removeWhere(test);
  }
}

typedef PasswordRemoveWhere = bool Function(String key, Password p);
