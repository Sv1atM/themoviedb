import 'dart:ui';

import 'package:themoviedb/configuration/network_configuration.dart';
import 'package:themoviedb/domain/api_client/account_api_client.dart';
import 'package:themoviedb/domain/api_client/api_client_exception.dart';
import 'package:themoviedb/domain/api_client/media_api_client.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/domain/entity/content_type.dart';
import 'package:themoviedb/domain/entity/media_type_base.dart';
import 'package:themoviedb/library/response.dart';

class MediaService {
  final _apiKey = NetworkConfiguration.apiKey;
  final _mediaApiClient = MediaApiClient();
  final _accountApiClient = AccountApiClient();
  final _sessionDataProvider = SessionDataProvider();

  Future<Response<T>> search<T extends MediaTypeBase>(
      MediaType mediaType, {
        required String query,
        required int page,
        Locale? locale,
      }) async {
    return _mediaApiClient.search<T>(
      mediaType,
      query: query,
      page: page,
      locale: locale,
      apiKey: _apiKey,
    );
  }

  Future<Response<T>> getPopular<T extends MediaTypeBase>(
      MediaType mediaType, {
        required int page,
        Locale? locale,
      }) async {
    return _mediaApiClient.getPopular<T>(
      mediaType,
      page: page,
      locale: locale,
      apiKey: _apiKey,
    );
  }

  Future<T> getDetails<T extends MediaTypeBase>(
      MediaType mediaType, {
        required int id,
        Locale? locale,
      }) async {
    final sessionId = await _sessionDataProvider.getSessionId();
    if (sessionId == null) {
      throw ApiClientException(ApiClientExceptionType.sessionExpired);
    }
    return _mediaApiClient.getDetails<T>(
      mediaType,
      id: id,
      sessionId: sessionId,
      locale: locale,
      apiKey: _apiKey,
    );
  }

  Future<Response<T>> getAccountStateList<T extends ContentType>(
      MediaType mediaType,
      AccountState state, {
        required int page,
        Locale? locale,
      }) async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final accountId = _sessionDataProvider.accountInfo?.id;
    if (sessionId == null || accountId == null) {
      throw ApiClientException(ApiClientExceptionType.sessionExpired);
    }
    return _accountApiClient.getAccountStateList<T>(
      mediaType,
      state,
      accountId: accountId,
      sessionId: sessionId,
      page: page,
      locale: locale,
      apiKey: _apiKey,
    );
  }

  Future<void> setAccountState(
      MediaType mediaType,
      AccountState state, {
        required int mediaId,
        required bool newState,
      }) async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final accountId = _sessionDataProvider.accountInfo?.id;
    if (sessionId == null || accountId == null) {
      throw ApiClientException(ApiClientExceptionType.sessionExpired);
    }
    return _accountApiClient.setAccountState(
      mediaType,
      state,
      accountId: accountId,
      sessionId: sessionId,
      mediaId: mediaId,
      newState: newState,
      apiKey: _apiKey,
    );
  }
}
