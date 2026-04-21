import 'dart:typed_data';

import 'package:unified_persistence/src/persistor_adapter.dart';

/// An adapter that persists and restores values in the local storage.
class LocalStoragePersistorAdapter implements PersistorAdapter {
  LocalStoragePersistorAdapter({required this.key});

  final String key;

  @override
  Future<void> persist(Uint8List? value) async {
    persistSync(value);
  }

  @override
  void persistSync(Uint8List? value) {
    throw UnsupportedError(
      'LocalStoragePersistor is only supported on web platforms.',
    );
  }

  @override
  Future<Uint8List?> restore() async {
    return restoreSync();
  }

  @override
  Uint8List? restoreSync() {
    throw UnsupportedError(
      'LocalStoragePersistor is only supported on web platforms.',
    );
  }
}
