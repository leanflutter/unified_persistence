import 'package:test/test.dart';
import 'package:unified_persistence/unified_persistence.dart';

class TestObject {
  TestObject({required this.value});
  final int value;

  @override
  String toString() => 'TestObject(value: $value)';

  static TestObject fromJson(Map<String, dynamic> json) =>
      TestObject(value: json['value']);

  Map<String, dynamic> toJson() => {'value': value};
}

void main() {
  group('JsonSerializer', () {
    late JsonSerializer<TestObject> serializer;

    setUp(() {
      serializer = JsonSerializer<TestObject>(
        toJson: (object) => object.toJson(),
        fromJson: (json) => TestObject.fromJson(json),
      );
    });

    test('serializes and deserializes object correctly', () {
      final testObject = TestObject(value: 42);
      final serialized = serializer.serialize(testObject);
      final deserialized = serializer.deserialize(serialized);

      expect(deserialized?.value, equals(testObject.value));
    });

    test('returns null when serializing null', () {
      final serialized = serializer.serialize(null);
      expect(serialized, isNull);
    });

    test('returns null when deserializing null', () {
      final deserialized = serializer.deserialize(null);
      expect(deserialized, isNull);
    });
  });
}
