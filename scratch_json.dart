import 'dart:convert';
import 'dart:io';

void main() {
  final Map<dynamic, dynamic> myMap = {
    'hello': 'world',
    'nested': {'key': 1},
  };
  final casted = jsonDecode(jsonEncode(myMap));

  stdout.writeln(casted is Map<String, dynamic>);
  stdout.writeln(casted['nested'] is Map<String, dynamic>);
}
