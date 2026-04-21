import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:unified_persistence/unified_persistence.dart';

void main() {
  group('MemoryPersistor', () {
    late MemoryPersistor<String> persistor;
    late JsonSerializer<String> serializer;

    setUp(() {
      serializer = JsonSerializer<String>(
        toJson: (value) => {'value': value},
        fromJson: (json) => json['value'] as String,
      );
      persistor = MemoryPersistor<String>(serializer: serializer);
    });

    test('persists and restores value', () async {
      const testValue = 'test value';
      await persistor.persist(testValue);
      expect(await persistor.restore(), equals(testValue));
    });

    test('persists and restores null value', () async {
      await persistor.persist(null);
      expect(await persistor.restore(), isNull);
    });

    test('persists and restores value synchronously', () {
      const testValue = 'test value';
      persistor.persistSync(testValue);
      expect(persistor.restoreSync(), equals(testValue));
    });

    test('persists and restores null value synchronously', () {
      persistor.persistSync(null);
      expect(persistor.restoreSync(), isNull);
    });
  });

  group('MemoryPersistorAdapter', () {
    late MemoryPersistorAdapter adapter;

    setUp(() {
      adapter = MemoryPersistorAdapter();
    });

    test('persists and restores bytes', () async {
      final testBytes = Uint8List.fromList([1, 2, 3]);
      await adapter.persist(testBytes);
      expect(await adapter.restore(), equals(testBytes));
    });

    test('persists and restores null bytes', () async {
      await adapter.persist(null);
      expect(await adapter.restore(), isNull);
    });

    test('persists and restores bytes synchronously', () {
      final testBytes = Uint8List.fromList([1, 2, 3]);
      adapter.persistSync(testBytes);
      expect(adapter.restoreSync(), equals(testBytes));
    });

    test('persists and restores null bytes synchronously', () {
      adapter.persistSync(null);
      expect(adapter.restoreSync(), isNull);
    });
  });
}
