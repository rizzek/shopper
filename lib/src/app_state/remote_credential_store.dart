import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RemoteCredentialStore {
  final _storage = const FlutterSecureStorage();

  Future storeSettings(RemoteStore store,
      String url, String username, String password) async {
    _storage.write(key: _storeStorageKey, value: store.name);
    await _storage.write(key: _urlStorageKey, value: url);
    await _storage.write(key: _usernameStorageKey, value: username);
    await _storage.write(key: _passwordStorageKey, value: password);
  }

  Future<StorageSettings> getSettings() async {
    final storedValues = await _storage.readAll();
    return StorageSettings(
      RemoteStore.values.byName(storedValues[_storeStorageKey] ?? "none"),
      storedValues[_urlStorageKey] ?? "",
      storedValues[_usernameStorageKey] ?? "",
      storedValues[_passwordStorageKey] ?? "",
    );
  }

  Future clearAll() async {
    _storage.deleteAll();
  }

  static const _storeStorageKey = "remote_store";

  static const _urlStorageKey = "remote_url";

  static const _usernameStorageKey = "remote_user";

  static const _passwordStorageKey = "remote_password";
}

class StorageSettings {
  StorageSettings(this.store, this.url, this.username, this.password);

  final RemoteStore store;
  final String url;
  final String username;
  final String password;
}

enum RemoteStore {
  webdav,
  nextcloud,
  none
}
