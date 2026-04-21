import 'dart:typed_data';

import 'package:unified_persistence/src/persistor.dart';
import 'package:unified_persistence/src/persistor_adapter.dart';

/// Stores raw bytes in memory for the lifetime of the current process.
class MemoryPersistorAdapter extends PersistorAdapter {
  Uint8List? _memoryStorage;

  @override
  Future<void> persist(Uint8List? value) async {
    _memoryStorage = value;
  }

  @override
  void persistSync(Uint8List? value) {
    _memoryStorage = value;
  }

  @override
  Future<Uint8List?> restore() async {
    return _memoryStorage;
  }

  @override
  Uint8List? restoreSync() {
    return _memoryStorage;
  }
}

/// A memory persistor that stores the data in memory.
class MemoryPersistor<T> extends Persistor<T> {
  /// Creates an in-memory persistor.
  MemoryPersistor({required super.serializer})
      : super(MemoryPersistorAdapter());
}
