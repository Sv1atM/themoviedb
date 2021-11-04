import 'package:themoviedb/configuration/network_configuration.dart';
import 'package:themoviedb/domain/api_client/account_api_client.dart';
import 'package:themoviedb/domain/api_client/auth_api_client.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';

class AuthService {
  final _apiKey = NetworkConfiguration.apiKey;
  final _authApiClient = AuthApiClient();
  final _accountApiClient = AccountApiClient();
  final _sessionDataProvider = SessionDataProvider();

  Future<bool> isAuth() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final isAuth = sessionId?.isNotEmpty ?? false;
    if (isAuth) {
      _sessionDataProvider.accountInfo ??= await _accountApiClient.getAccountInfo(
        sessionId: sessionId!,
        apiKey: _apiKey,
      );
    }
    return isAuth;
  }

  Future<void> login(String username, String password) async {
    final sessionId = await _auth(username, password);
    await _sessionDataProvider.setSessionId(sessionId);
    _sessionDataProvider.accountInfo = await _accountApiClient.getAccountInfo(
      sessionId: sessionId,
      apiKey: _apiKey,
    );
  }

  Future<void> logout() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    if (sessionId != null) {
      await _authApiClient.closeSession(
        sessionId: sessionId,
        apiKey: _apiKey,
      );
    }
    await _sessionDataProvider.deleteSessionId();
  }

  Future<String> _auth(String username, String password) async {
    final requestToken = await _authApiClient.makeToken(
      apiKey: _apiKey,
    );
    final validToken = await _authApiClient.validateUser(
      username: username,
      password: password,
      requestToken: requestToken,
      apiKey: _apiKey,
    );
    final sessionId = await _authApiClient.makeSession(
      requestToken: validToken,
      apiKey: _apiKey,
    );
    return sessionId;
  }
}
