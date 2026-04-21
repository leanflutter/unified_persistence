import 'dart:io';
import 'dart:typed_data';

import 'package:unified_persistence/src/persistor_adapter.dart';

class FilePersistorAdapter implements PersistorAdapter {
  FilePersistorAdapter({required this.filePath});

  final String filePath;

  File? _file;
  File get file => _file ??= File(filePath);

  @override
  Future<void> persist(Uint8List? value) async {
    if (value == null) {
      await file.delete();
    } else {
      await file.writeAsBytes(value);
    }
  }

  @override
  void persistSync(Uint8List? value) {
    if (value == null) {
      file.deleteSync();
    } else {
      file.writeAsBytesSync(value);
    }
  }

  @override
  Future<Uint8List?> restore() async {
    if (!await file.exists()) {
      return null;
    }
    return await file.readAsBytes();
  }

  @override
  Uint8List? restoreSync() {
    if (!file.existsSync()) {
      return null;
    }
    return file.readAsBytesSync();
  }
}
