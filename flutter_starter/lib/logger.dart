class Logger {
  static const Logger _instance = Logger._internal();
  // ファクトリコンストラクタはインスタンスを自動生成しない
  factory Logger() {
    return _instance;
  }
  // 内部コンストラクタ
  const Logger._internal();
  void info(String message) {
    final now = getTs();
    print('$now\tINFO\t$message');
  }

  static String getTs() {
    return DateTime.now().toString();
  }
}
