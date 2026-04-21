import 'package:unified_persistence/unified_persistence.dart';

class UserProfile {
  UserProfile({required this.name});

  final String name;

  Map<String, dynamic> toJson() => {'name': name};

  static UserProfile fromJson(Map<String, dynamic> json) {
    return UserProfile(name: json['name'] as String);
  }
}

Future<void> main() async {
  final persistor = MemoryPersistor<UserProfile>(
    serializer: JsonSerializer<UserProfile>(
      toJson: (value) => value.toJson(),
      fromJson: UserProfile.fromJson,
    ),
  );

  await persistor.persist(UserProfile(name: 'Alice'));
  final restored = await persistor.restore();

  if (restored?.name != 'Alice') {
    throw StateError('Failed to restore the persisted profile.');
  }
}
