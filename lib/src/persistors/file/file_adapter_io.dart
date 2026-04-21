import 'dart:io';
import 'dart:typed_data';

import 'package:unified_persistence/src/persistor_adapter.dart';

class FilePersistorAdapter implements PersistorAdapter {
  FilePersistorAdapter({required this.filePath});

  final String filePath;

  File? _file;
  File get file => _file ??= File(filePath);

  Future<void> _deleteIfExists() async {
    if (await file.exists()) {
      await file.delete();
    }
  }

  void _deleteIfExistsSync() {
    if (file.existsSync()) {
      file.deleteSync();
    }
  }

  Future<void> _ensureParentDirectoryExists() async {
    final Directory parent = file.parent;
    if (!await parent.exists()) {
      await parent.create(recursive: true);
    }
  }

  void _ensureParentDirectoryExistsSync() {
    final Directory parent = file.parent;
    if (!parent.existsSync()) {
      parent.createSync(recursive: true);
    }
  }

  @override
  Future<void> persist(Uint8List? value) async {
    if (value == null) {
      await _deleteIfExists();
    } else {
      await _ensureParentDirectoryExists();
      await file.writeAsBytes(value);
    }
  }

  @override
  void persistSync(Uint8List? value) {
    if (value == null) {
      _deleteIfExistsSync();
    } else {
      _ensureParentDirectoryExistsSync();
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
