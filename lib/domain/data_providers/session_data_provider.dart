import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:themoviedb/domain/entity/account_info.dart';

abstract class _Keys {
  static const sessionId = 'session_id';
}

class SessionDataProvider {
  factory SessionDataProvider() => _instance;

  SessionDataProvider._private();

  static final _instance = SessionDataProvider._private();
  static const _secureStorage = FlutterSecureStorage();
  AccountInfo? accountInfo;

  Future<void> setSessionId(String value) async =>
      _secureStorage.write(key: _Keys.sessionId, value: value);

  Future<void> deleteSessionId() async =>
      _secureStorage.delete(key: _Keys.sessionId);

  Future<String?> getSessionId() async =>
      _secureStorage.read(key: _Keys.sessionId);
}
