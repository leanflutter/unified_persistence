import 'dart:convert';
import 'dart:typed_data';

/// Defines the low-level byte storage contract used by a [Persistor].
abstract class PersistorAdapter {
  /// Persists [value] asynchronously.
  Future<void> persist(Uint8List? value);

  /// Persists [value] synchronously.
  void persistSync(Uint8List? value);

  /// Restores a previously persisted value asynchronously.
  Future<Uint8List?> restore();

  /// Restores a previously persisted value synchronously.
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
