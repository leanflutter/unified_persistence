# unified_persistence

Unified persistence primitives for Dart and Flutter applications.

`unified_persistence` provides a small abstraction around:

- a `PersistorAdapter` that reads and writes bytes
- a `PersistorSerializer<T>` that converts typed values to and from bytes
- a `Persistor<T>` that combines the two

## Install

```yaml
dependencies:
  unified_persistence: ^0.0.3
```

## Quick Start

Use `Persistor<T>` when you want a typed API for saving and restoring values.

```dart
import 'package:unified_persistence/unified_persistence.dart';

class UserProfile {
  UserProfile({required this.name});

  final String name;

  Map<String, dynamic> toJson() => {'name': name};

  static UserProfile fromJson(Map<String, dynamic> json) {
    return UserProfile(name: json['name'] as String);
  }
}

final persistor = MemoryPersistor<UserProfile>(
  serializer: JsonSerializer<UserProfile>(
    toJson: (value) => value.toJson(),
    fromJson: UserProfile.fromJson,
  ),
);

await persistor.persist(UserProfile(name: 'Alice'));
final profile = await persistor.restore();
```

## Built-in Persistors

### Memory

Useful for tests or temporary in-memory caching.

```dart
final persistor = MemoryPersistor<Map<String, dynamic>>(
  serializer: JsonSerializer<Map<String, dynamic>>(
    toJson: (value) => value,
    fromJson: (json) => json,
  ),
);
```

### File

Use `FilePersistor<T>` when you want to store serialized bytes in a file.

```dart
final persistor = FilePersistor<UserProfile>(
  filePath: './profile.json',
  serializer: JsonSerializer<UserProfile>(
    toJson: (value) => value.toJson(),
    fromJson: UserProfile.fromJson,
  ),
);
```

If you only need JSON file persistence, `JsonFilePersistor<T>` is shorter:

```dart
final persistor = JsonFilePersistor<UserProfile>(
  filePath: './profile.json',
  toJson: (value) => value.toJson(),
  fromJson: UserProfile.fromJson,
);
```

### Browser Storage

Use `LocalStoragePersistor<T>` or `SessionStoragePersistor<T>` on web.

```dart
final persistor = LocalStoragePersistor<UserProfile>(
  key: 'profile',
  serializer: JsonSerializer<UserProfile>(
    toJson: (value) => value.toJson(),
    fromJson: UserProfile.fromJson,
  ),
);
```

## Synchronous API

Every persistor also supports synchronous access:

```dart
persistor.persistSync(UserProfile(name: 'Alice'));
final profile = persistor.restoreSync();
```

## Platform Notes

- `MemoryPersistor` works everywhere.
- `FilePersistor` and `JsonFilePersistor` are for `dart:io` platforms and throw on web.
- `LocalStoragePersistor` and `SessionStoragePersistor` are for web and throw on non-web platforms.

## Release

Publishing to pub.dev is automated through GitHub Actions on version tags that
match `v{{version}}`, for example `v0.0.1`.

If you create a GitHub Release with a new tag such as `v0.0.1`, GitHub pushes
that tag and the publish workflow will run automatically.

Before this works, enable automated publishing for this package on pub.dev and
configure:

- Repository: `leanflutter/unified_persistence`
- Tag pattern: `v{{version}}`

Notes:

- The version in `pubspec.yaml` must match the release tag.
- The first version of a package must still be published manually on pub.dev
  before automated publishing can be used.
