import 'package:unified_persistence/src/persistor.dart';
import 'package:unified_persistence/src/persistors/local_storage/local_storage_adapter.dart';

/// A persistor that persists and restores values in the local storage.
class LocalStoragePersistor<T> extends Persistor<T> {
  LocalStoragePersistor({
    required String key,
    required super.serializer,
  }) : super(LocalStoragePersistorAdapter(key: key));
}
