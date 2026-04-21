import 'package:unified_persistence/src/persistor.dart';
import 'package:unified_persistence/src/persistors/file/file_adapter.dart';
import 'package:unified_persistence/src/serializers/json_serializer.dart';

class JsonFilePersistor<T> extends Persistor<T> {
  JsonFilePersistor({
    required String filePath,
    required Map<String, dynamic> Function(T object) toJson,
    required T Function(Map<String, dynamic> json) fromJson,
  }) : super(
          FilePersistorAdapter(filePath: filePath),
          serializer: JsonSerializer<T>(toJson: toJson, fromJson: fromJson),
        );
}
