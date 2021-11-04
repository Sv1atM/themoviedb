import 'package:themoviedb/domain/api_client/network_client.dart';

class AuthApiClient {
  final _networkClient = NetworkClient();

  Future<void> closeSession({
    required String sessionId,
    required String apiKey,
  }) async {
    return _networkClient.makeRequest(
      RequestType.delete,
      '/authentication/session',
      urlParameters: <String, dynamic>{
        'api_key': apiKey,
      },
      bodyParameters: <String, dynamic>{
        'session_id': sessionId,
      },
      parser: (dynamic json) {},
    );
  }

  Future<String> makeToken({
    required String apiKey,
  }) async {
    return _networkClient.makeRequest(
      RequestType.get,
      '/authentication/token/new',
      urlParameters: <String, dynamic>{
        'api_key': apiKey,
      },
      parser: (dynamic json) {
        final jsonMap = json as Map<String, dynamic>;
        return jsonMap['request_token'] as String;
      },
    );
  }

  Future<String> validateUser({
    required String username,
    required String password,
    required String requestToken,
    required String apiKey,
  }) async {
    return _networkClient.makeRequest(
      RequestType.post,
      '/authentication/token/validate_with_login',
      urlParameters: <String, dynamic>{
        'api_key': apiKey,
      },
      bodyParameters: <String, dynamic>{
        'username': username,
        'password': password,
        'request_token': requestToken,
      },
      parser: (dynamic json) {
        final jsonMap = json as Map<String, dynamic>;
        return jsonMap['request_token'] as String;
      },
    );
  }

  Future<String> makeSession({
    required String requestToken,
    required String apiKey,
  }) async {
    return _networkClient.makeRequest(
      RequestType.post,
      '/authentication/session/new',
      urlParameters: <String, dynamic>{
        'api_key': apiKey,
      },
      bodyParameters: <String, dynamic>{
        'request_token': requestToken,
      },
      parser: (dynamic json) {
        final jsonMap = json as Map<String, dynamic>;
        return jsonMap['session_id'] as String;
      },
    );
  }
}
