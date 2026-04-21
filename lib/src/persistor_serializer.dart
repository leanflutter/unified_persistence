import 'dart:typed_data';

/// Converts typed values to and from raw bytes for a [Persistor].
abstract class PersistorSerializer<T> {
  /// Serializes the object to a [Uint8List].
  Uint8List? serialize(T? object);

  /// Deserializes the [Uint8List] to an object.
  T? deserialize(Uint8List? source);
}
