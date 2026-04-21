import 'dart:convert';
import 'dart:typed_data';

abstract class PersistorAdapter {
  Future<void> persist(Uint8List? value);

  void persistSync(Uint8List? value);

  Future<Uint8List?> restore();

  Uint8List? restoreSync();
}

/// Converts a string to a [Uint8List].
Uint8List? stringToUint8List(String? data) {
  if (data == null) return null;
  return Uint8List.fromList(utf8.encode(data));
}

/// Converts a [Uint8List] to a string.
String? uint8ListToString(Uint8List? data) {
  if (data == null) return null;
  return utf8.decode(data);
}
