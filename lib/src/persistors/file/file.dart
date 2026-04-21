import 'package:unified_persistence/src/persistor.dart';
import 'package:unified_persistence/src/persistors/file/file_adapter.dart';

/// Persists values to a file using the provided serializer.
class FilePersistor<T> extends Persistor<T> {
  /// Creates a file-based persistor for [filePath].
  FilePersistor({
    required String filePath,
    required super.serializer,
  }) : super(FilePersistorAdapter(filePath: filePath));
}
