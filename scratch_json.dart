import 'dart:convert';

void main() {
  Map<dynamic, dynamic> myMap = {'hello': 'world', 'nested': {'key': 1}};
  final casted = jsonDecode(jsonEncode(myMap));
  print(casted is Map<String, dynamic>);
  print(casted['nested'] is Map<String, dynamic>);
}
