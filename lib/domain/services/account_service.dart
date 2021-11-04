import 'package:themoviedb/configuration/network_configuration.dart';
import 'package:themoviedb/domain/api_client/account_api_client.dart';
import 'package:themoviedb/domain/api_client/api_client_exception.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/domain/entity/account_info.dart';

class AccountService {
  final _apiKey = NetworkConfiguration.apiKey;
  final _accountApiClient = AccountApiClient();
  final _sessionDataProvider = SessionDataProvider();

  Future<AccountInfo> getAccountInfo() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    if (sessionId == null) {
      throw ApiClientException(ApiClientExceptionType.sessionExpired);
    }
    return _accountApiClient.getAccountInfo(
      sessionId: sessionId,
      apiKey: _apiKey,
    );
  }
}
