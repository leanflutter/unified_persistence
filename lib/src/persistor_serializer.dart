import 'dart:typed_data';

abstract class PersistorSerializer<T> {
  /// Serializes the object to a [Uint8List].
  Uint8List? serialize(T? object);

  /// Deserializes the [Uint8List] to an object.
  T? deserialize(Uint8List? source);
}
