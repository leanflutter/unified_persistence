import 'package:unified_persistence/src/persistor.dart';
import 'package:unified_persistence/src/persistors/session_storage/session_storage_adapter.dart';

/// A persistor that persists and restores values in browser session storage.
class SessionStoragePersistor<T> extends Persistor<T> {
  /// Creates a session-storage persistor for the given browser storage [key].
  SessionStoragePersistor({
    required String key,
    required super.serializer,
  }) : super(SessionStoragePersistorAdapter(key: key));
}
