import 'dart:convert';
import 'dart:mirrors';

Future<void> main() async {
  const user = User(name: 'john.doe', age: 30, married: true);
  // const user = User(
  //     name: 'john.doe', age: 30, married: true, pet: Animal(name: 'snake'));
  print(user.toJsonString());
  Json.fromJson(reflect(user), user.toJsonString());
}

mixin Json {
  String toJsonString() {
    var buffer = StringBuffer();
    buffer.write("{");
    InstanceMirror instancaeMirror = reflect(this);
    ClassMirror classMirror = instancaeMirror.type;
    var fields = classMirror.instanceMembers.entries
        .where((element) =>
            !element.value.isStatic &&
            !element.value.isPrivate &&
            element.value.isSynthetic)
        .toList();
    for (var i = 0; i < fields.length; i++) {
      final field = fields[i];
      var instanceField = instancaeMirror.getField(field.key).reflectee;
      String name_of_symbol = MirrorSystem.getName(field.key);
      if (instanceField is String) {
        buffer.write('"${name_of_symbol}": "${instanceField}"');
      } else if (instanceField is int ||
          instanceField is double ||
          instanceField is bool) {
        buffer.write('"${name_of_symbol}": ${instanceField}');
      } else {
        final childInstanceMirror = reflect(instanceField);
        ClassMirror childClassMirror = childInstanceMirror.type;
        childClassMirror.instanceMembers.forEach((k, d) {
          if (d is MethodMirror && d.simpleName == Symbol('toJsonString')) {
            var invokeResult = childInstanceMirror.invoke(d.simpleName, []);
            buffer.write('"${name_of_symbol}": ${invokeResult.reflectee}');
          }
        });
      }
      if (i < fields.length - 1) {
        buffer.write(",");
      }
    }
    buffer.write("}");
    return buffer.toString();
  }

  static T? fromJson<T>(InstanceMirror instanceMirror, String json) {
    Map<String, dynamic> decoded = jsonDecode(json);
    print("name: ${decoded['name']}");
    print("age: ${decoded['age']}");
    print("married: ${decoded['married']}");
    print("pet: ${decoded['pet']}");
    // final newInstance = instanceMirror.type.newInstance(const Symbol(''), []);
    // print(newInstance);
  }
}

class User with Json {
  final String name;
  final int age;
  // final Animal pet;
  final bool married;
  // const User(
  //     {required this.name,
  //     required this.age,
  //     required this.married,
  //     required this.pet});
  const User({required this.name, required this.age, required this.married});
}

class Animal with Json {
  final String name;
  const Animal({required this.name});
}
