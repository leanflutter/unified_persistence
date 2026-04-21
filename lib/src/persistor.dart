import 'dart:typed_data';

import 'package:unified_persistence/src/persistor_adapter.dart';
import 'package:unified_persistence/src/persistor_serializer.dart';

/// A class that persists and restores values of a given type.
///
/// [Persistor] is a wrapper around a [PersistorAdapter] and a [PersistorSerializer].
/// It provides methods to persist and restore values of a given type.
class Persistor<T> {
  const Persistor(
    this.adapter, {
    required this.serializer,
  });

  /// The adapter that persists and restores values.
  final PersistorAdapter adapter;

  /// The serializer that serializes and deserializes values.
  final PersistorSerializer<T> serializer;

  /// Persists the given value.
  Future<void> persist(T? value) async {
    await adapter.persist(serializer.serialize(value));
  }

  /// Persists the given value synchronously.
  void persistSync(T? value) {
    adapter.persistSync(serializer.serialize(value));
  }

  /// Restores the value from the storage.
  Future<T?> restore() async {
    final Uint8List? source = await adapter.restore();
    return serializer.deserialize(source);
  }

  /// Restores the value from the storage synchronously.
  T? restoreSync() {
    final Uint8List? source = adapter.restoreSync();
    return serializer.deserialize(source);
  }
}
