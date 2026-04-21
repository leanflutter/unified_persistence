import 'dart:typed_data';

import 'package:unified_persistence/src/persistor_adapter.dart';

class FilePersistorAdapter implements PersistorAdapter {
  FilePersistorAdapter({required this.filePath});

  final String filePath;

  @override
  Future<void> persist(Uint8List? value) async {
    throw UnsupportedError('Not supported in web');
  }

  @override
  void persistSync(Uint8List? value) {
    throw UnsupportedError('Not supported in web');
  }

  @override
  Future<Uint8List?> restore() async {
    throw UnsupportedError('Not supported in web');
  }

  @override
  Uint8List? restoreSync() {
    throw UnsupportedError('Not supported in web');
  }
}
