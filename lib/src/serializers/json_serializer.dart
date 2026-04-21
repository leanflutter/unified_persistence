import 'dart:convert';
import 'dart:typed_data';

import 'package:unified_persistence/unified_persistence.dart';

/// A serializer that serializes and deserializes values to and from JSON.
class JsonSerializer<T> implements PersistorSerializer<T> {
  JsonSerializer({
    required this.toJson,
    required this.fromJson,
  });

  final Map<String, dynamic> Function(T object) toJson;
  final T Function(Map<String, dynamic> json) fromJson;

  @override
  Uint8List? serialize(T? object) {
    if (object == null) return null;
    Map<String, dynamic> json = toJson(object);
    String jsonString = jsonEncode(json);
    return stringToUint8List(jsonString);
  }

  @override
  T? deserialize(Uint8List? source) {
    if (source == null) return null;
    String? jsonString = uint8ListToString(source);
    if (jsonString == null) return null;
    return fromJson(jsonDecode(jsonString));
  }
}
