// Flutter開発で最低限知っておきたいDartの基礎知識を受けた時のコード

void main() async {
  print('Hello, World!');
  intAndDouble();
  stringDataType();
  boolTypeValue();
  listTypeValue();
  mapTypeValue();
  varTypeValue();
  functionType();
  userClass();
  future();
  classAndInstance();
  finalAndConst();
  print(StaticValue.getInstance());
  operators();
  ternaryOperators();
  /**
   * 変数のスコープ
   * 関数内で定義された変数 -> ブロックスコープ内でのみ有効
   * グローバル変数も作れる
   */
  var privateValue = 'Private Valueです';
  print(privateValue);
  print(globalValue);
  swithStatement();
  enumSample();
  iterateStatement();
  tryCatchStatement();
  nullSafety();
}

void nullSafety() {
  int num = 0; // OK
  // int num2 = null; // NG
  int? num2 = null; // OK(Nullable)
  print(num);
  print(num2);
  void sum({int? x, int? y}) {
    if (y == null) {
      y = 0;
    }
    if (x == null) {
      x = 0;
    }
    print(x + y);
  }

  sum(x: 1, y: 2);
  sum(x: 1);
  sum(y: 1);
}

void tryCatchStatement() {
  try {
    print('tryします');
    throw ('エラーが発生しました');
  } catch (e) {
    print('catchしました $e');
  } finally {
    print('finallyを実行します');
  }
}

void iterateStatement() {
  for (int i = 0; i < 10; i++) {
    print('iは$iです');
  }
  List<String> names = ['奥野', '田中', '佐藤'];
  for (String name in names) {
    print('Name=$name');
  }

  bool loop = true;
  int num = 0;
  while (loop) {
    print(num);
    if (num == 5) {
      break;
    }
    num++;
  }
}

void enumSample() {
  void test(Animals animal) {
    switch (animal) {
      case Animals.Cat:
        print('猫です');
        break;
      case Animals.Dog:
        print('犬です');
        break;
      case Animals.Jiraffe:
        print('キリンです');
    }
  }

  test(Animals.Cat);
  test(Animals.Dog);
  test(Animals.Jiraffe);
}

enum Animals { Cat, Dog, Jiraffe }

void swithStatement() {
  for (var i = 0; i <= 10; i++) {
    switch (i) {
      case 0:
        print('num = 0');
        break;
      case 1:
        print('num = 1');
        break;
      case 20:
        print('num = 20');
        break;
      default:
        print('num = $i は0でも1でもありません');
    }
  }
}

var globalValue = "Global Valueです";

void ternaryOperators() {
  for (var i = 0; i <= 25; i++) {
    i >= 20 ? print('$i is adult') : print('$i is not adult');
  }
}

void operators() {
  // 足す
  print(0.5 + 0.5);
  // 引く
  print(3 - 1);
  // 掛ける
  print(3 * 1);
  // 割る
  print(8 / 2);
  // あまり
  print(15 % 10);
  // 割った回数
  print(60 ~/ 10);
}

class StaticValue {
  const StaticValue();
  static StaticValue getInstance() {
    return StaticValue();
  }

  @override
  String toString() {
    return 'I have a static method.';
  }
}

void finalAndConst() {
  // 実行時定数
  final String str1 = 'final';
  print(str1);
  // コンパイル時定数
  const str2 = 'const';
  print(str2);
  // finalには変数を入れられるが、constには入れられない
  final String str3 = StringBuffer().toString();
  // Const variables must be initialized with a constant value.
  // const String str4 = StringBuffer().toString();
  print('str3: $str3');
}

void classAndInstance() {
  var users = [];
  users.add(User(name: '奥野', age: 24));
  users.add(User(name: '田中', age: 18));
  print(users);
  print(users[0].name);
  print(users[0].age);
}

void future() async {
  void test(int num) {
    log('Start $num');
    log('Finish $num');
  }

  Future<void> test2() async {
    log('Async Task Start');
    await Future.delayed(Duration(seconds: 3));
    log('Async Task Finish');
  }

  test(1);
  await test2();
  test(1);
}

void log(String message) {
  final now = DateTime.now().toUtc();
  print('$now: message: $message');
}

class User {
  // コンストラクタの書き方
  const User({required String this.name, required int this.age});
  final String name;
  final int age;
  @override
  String toString() {
    return '{"name": "$name", "age": $age}';
  }
}

void userClass() {
  var user = User(name: '山中', age: 51);
  print(user);
}

void functionType() {
  var printNumber = (int number) {
    print(number);
  };
  printNumber(100);
  var namedParamFunction = ({required int x, required int y}) {
    print(x * y);
  };
  namedParamFunction(x: 10, y: 10);
  namedParamFunction(x: 10, y: 1);
  var arrowFunction = (int a) => print(a);
  arrowFunction(114);
  arrowFunction(514);
}

void varTypeValue() {
  // どんなデータでも突っ込める枠
  var varValue;
  // var varValue = "AAA"; // 初期値を宣言すると、型が決定する
  varValue = 'AAA';
  print(varValue);
  varValue = 1;
  print(varValue);
  varValue = 1.5;
  print(varValue);
  varValue = {'A': 1, 'B': 2, 'C': 3};
  print(varValue);
}

void mapTypeValue() {
  Map<int, String> map = {1: 'A', 2: 'B', 3: 'C'};
  print(map);
  print(map[1]);
  print(map[2]);
  print(map[3]);
  map[4] = 'D';
  print(map);
}

void listTypeValue() {
  List<String> values = ['A', 'B', 'C'];
  print(values);
  values.add('D');
  values.add('E');
  values.add('F');
  print(values);
  int i = 0;
  var printElement = (element) {
    print('element is $element; $i');
    i++;
  };
  values.forEach(printElement);
  values.map((value) {
    return 'value is $value';
  }).forEach(printElement);
  values.forEach(printElement);
}

void boolTypeValue() {
  bool empty = true;
  isEmpty(empty);
  empty = false;
  isEmpty(empty);
}

void isEmpty(bool empty) {
  if (empty) {
    print('空です');
  } else {
    print('空ではないです');
  }
}

void stringDataType() {
  String stringValue = 'String';
  print('String value is $stringValue');
  var buffer = StringBuffer();
  buffer.write('Hello,');
  buffer.write(' ');
  buffer.write('World!');
  stringValue = buffer.toString();
  print('String value is $stringValue');
  var buffer2 = StringBuffer();
  buffer2.writeln('1');
  buffer2.writeln('2');
  buffer2.writeln('3');
  print('String value is $buffer2');
}

void intAndDouble() {
  int intValue = 0;
  print('int value is $intValue');
  double doubleValue = 1.75;
  print('double value is $doubleValue');
}
