import 'dart:typed_data';

import 'package:unified_persistence/src/persistor_adapter.dart';
import 'package:web/web.dart' show Storage, window;

class LocalStoragePersistorAdapter implements PersistorAdapter {
  LocalStoragePersistorAdapter({required this.key});

  final String key;

  Storage get _localStorage => window.localStorage;

  @override
  Future<void> persist(Uint8List? value) async {
    persistSync(value);
  }

  @override
  void persistSync(Uint8List? value) {
    String? valueString = uint8ListToString(value);
    if (valueString != null) {
      _localStorage.setItem(key, valueString);
    } else {
      _localStorage.removeItem(key);
    }
  }

  @override
  Future<Uint8List?> restore() async {
    return restoreSync();
  }

  @override
  Uint8List? restoreSync() {
    String? valueString = _localStorage.getItem(key);
    if (valueString != null) {
      return stringToUint8List(valueString);
    }
    return null;
  }
}
