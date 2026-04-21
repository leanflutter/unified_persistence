import 'dart:io';

import 'package:test/test.dart';
import 'package:unified_persistence/unified_persistence.dart';

class _TestValue {
  _TestValue({required this.value});

  final String value;

  Map<String, dynamic> toJson() => {'value': value};

  static _TestValue fromJson(Map<String, dynamic> json) {
    return _TestValue(value: json['value'] as String);
  }
}

void main() {
  group('FilePersistor', () {
    late Directory tempDir;
    late JsonSerializer<_TestValue> serializer;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp(
        'unified_persistence_file_test_',
      );
      serializer = JsonSerializer<_TestValue>(
        toJson: (value) => value.toJson(),
        fromJson: _TestValue.fromJson,
      );
    });

    tearDown(() async {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    test('creates parent directories when persisting values', () async {
      final filePath = '${tempDir.path}/nested/deep/value.json';
      final persistor = FilePersistor<_TestValue>(
        filePath: filePath,
        serializer: serializer,
      );
      final value = _TestValue(value: 'hello');

      await persistor.persist(value);

      expect(File(filePath).existsSync(), isTrue);
      expect((await persistor.restore())?.value, 'hello');
    });

    test('creates parent directories when persisting values synchronously', () {
      final filePath = '${tempDir.path}/nested/deep/value.json';
      final persistor = FilePersistor<_TestValue>(
        filePath: filePath,
        serializer: serializer,
      );
      final value = _TestValue(value: 'hello');

      persistor.persistSync(value);

      expect(File(filePath).existsSync(), isTrue);
      expect(persistor.restoreSync()?.value, 'hello');
    });

    test('deleting a missing file is a no-op', () async {
      final filePath = '${tempDir.path}/missing/value.json';
      final persistor = FilePersistor<_TestValue>(
        filePath: filePath,
        serializer: serializer,
      );

      await persistor.persist(null);

      expect(await persistor.restore(), isNull);
    });

    test('deleting a missing file synchronously is a no-op', () {
      final filePath = '${tempDir.path}/missing/value.json';
      final persistor = FilePersistor<_TestValue>(
        filePath: filePath,
        serializer: serializer,
      );

      persistor.persistSync(null);

      expect(persistor.restoreSync(), isNull);
    });
  });

  group('Non-web storage persistors', () {
    late JsonSerializer<String> serializer;

    setUp(() {
      serializer = JsonSerializer<String>(
        toJson: (value) => {'value': value},
        fromJson: (json) => json['value'] as String,
      );
    });

    test('local storage persistor throws a clear error message', () {
      final persistor = LocalStoragePersistor<String>(
        key: 'test',
        serializer: serializer,
      );

      expect(
        () => persistor.persistSync('value'),
        throwsA(
          isA<UnsupportedError>().having(
            (error) => error.message,
            'message',
            'LocalStoragePersistor is only supported on web platforms.',
          ),
        ),
      );
      expect(
        () => persistor.restoreSync(),
        throwsA(
          isA<UnsupportedError>().having(
            (error) => error.message,
            'message',
            'LocalStoragePersistor is only supported on web platforms.',
          ),
        ),
      );
    });

    test('session storage persistor throws a clear error message', () {
      final persistor = SessionStoragePersistor<String>(
        key: 'test',
        serializer: serializer,
      );

      expect(
        () => persistor.persistSync('value'),
        throwsA(
          isA<UnsupportedError>().having(
            (error) => error.message,
            'message',
            'SessionStoragePersistor is only supported on web platforms.',
          ),
        ),
      );
      expect(
        () => persistor.restoreSync(),
        throwsA(
          isA<UnsupportedError>().having(
            (error) => error.message,
            'message',
            'SessionStoragePersistor is only supported on web platforms.',
          ),
        ),
      );
    });
  });
}
