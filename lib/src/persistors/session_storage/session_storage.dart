import 'package:unified_persistence/src/persistor.dart';
import 'package:unified_persistence/src/persistors/session_storage/session_storage_adapter.dart';

class SessionStoragePersistor<T> extends Persistor<T> {
  SessionStoragePersistor({
    required String key,
    required super.serializer,
  }) : super(SessionStoragePersistorAdapter(key: key));
}
