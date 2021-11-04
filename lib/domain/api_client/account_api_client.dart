import 'dart:ui';

import 'package:themoviedb/domain/api_client/network_client.dart';
import 'package:themoviedb/domain/entity/account_info.dart';
import 'package:themoviedb/domain/entity/content_type.dart';
import 'package:themoviedb/domain/entity/media_type_base.dart';
import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/library/response.dart';
import 'package:themoviedb/domain/entity/tv.dart';

class AccountApiClient {
  final _networkClient = NetworkClient();

  Future<AccountInfo> getAccountInfo({
    required String sessionId,
    required String apiKey,
  }) async {
    return _networkClient.makeRequest(
      RequestType.get,
      '/account',
      urlParameters: <String, dynamic>{
        'api_key': apiKey,
        'session_id': sessionId,
      },
      parser: (dynamic json) {
        final jsonMap = json as Map<String, dynamic>;
        return AccountInfo.fromJson(jsonMap);
      },
    );
  }

  Future<Response<T>> getAccountStateList<T extends ContentType>(
      MediaType mediaType,
      AccountState state, {
        required int accountId,
        required String sessionId,
        required int page,
        Locale? locale,
        required String apiKey,
      }) async {
    final String listName;
    switch (mediaType) {
      case MediaType.movie:
        listName = 'movies';
        break;
      case MediaType.tv:
        listName = 'tv';
        break;
      default:
        throw Error();
    }
    return _networkClient.makeRequest(
      RequestType.get,
      '/account/$accountId/${state.asString()}/$listName',
      urlParameters: <String, dynamic>{
        'api_key': apiKey,
        'session_id': sessionId,
        'page': page.toString(),
        if (locale != null)
          'language': locale.languageCode,
        'sort_by': 'created_at.desc',
      },
      parser: (dynamic json) {
        final jsonMap = json as Map<String, dynamic>;
        switch (mediaType) {
          case MediaType.movie:
            return Response<Movie>.fromJson(jsonMap, (json) =>
                Movie.fromJson(json as Map<String, dynamic>)) as Response<T>;
          case MediaType.tv:
            return Response<TV>.fromJson(jsonMap, (json) =>
                TV.fromJson(json as Map<String, dynamic>)) as Response<T>;
          default:
            throw TypeError();
        }
      },
    );
  }

  Future<void> setAccountState(
      MediaType mediaType,
      AccountState state, {
        required int accountId,
        required String sessionId,
        required int mediaId,
        required bool newState,
        required String apiKey,
      }) async {
    final setState = state.asString();
    return _networkClient.makeRequest(
      RequestType.post,
      '/account/$accountId/$setState',
      urlParameters: <String, dynamic>{
        'api_key': apiKey,
        'session_id': sessionId,
      },
      bodyParameters: <String, dynamic>{
        'media_type': mediaType.asString(),
        'media_id': mediaId,
        setState: newState,
      },
      parser: (dynamic json) {},
    );
  }
}
