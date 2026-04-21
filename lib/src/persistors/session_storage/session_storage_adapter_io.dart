import 'dart:typed_data';

import 'package:unified_persistence/src/persistor_adapter.dart';

class SessionStoragePersistorAdapter implements PersistorAdapter {
  SessionStoragePersistorAdapter({required this.key});

  final String key;

  @override
  Future<void> persist(Uint8List? value) async {
    persistSync(value);
  }

  @override
  void persistSync(Uint8List? value) {
    throw UnsupportedError(
      'SessionStoragePersistor is only supported on web platforms.',
    );
  }

  @override
  Future<Uint8List?> restore() async {
    return restoreSync();
  }

  @override
  Uint8List? restoreSync() {
    throw UnsupportedError(
      'SessionStoragePersistor is only supported on web platforms.',
    );
  }
}
