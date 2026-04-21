import 'package:unified_persistence/src/persistor.dart';
import 'package:unified_persistence/src/persistors/file/file_adapter.dart';

class FilePersistor<T> extends Persistor<T> {
  FilePersistor({
    required String filePath,
    required super.serializer,
  }) : super(FilePersistorAdapter(filePath: filePath));
}
