import 'dart:ui';

import 'package:themoviedb/domain/api_client/network_client.dart';
import 'package:themoviedb/domain/entity/media_type_base.dart';
import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/domain/entity/person.dart';
import 'package:themoviedb/library/response.dart';
import 'package:themoviedb/domain/entity/tv.dart';

class MediaApiClient {
  final _networkClient = NetworkClient();

  Future<Response<T>> search<T extends MediaTypeBase>(
      MediaType mediaType, {
        required String query,
        required int page,
        Locale? locale,
        required String apiKey,
      }) async {
    return _networkClient.makeRequest(
      RequestType.get,
      '/search/${mediaType.asString()}',
      urlParameters: <String, dynamic>{
        'api_key': apiKey,
        'query': query,
        'page': page.toString(),
        if (locale != null)
          'language': locale.languageCode,
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
          case MediaType.person:
            return Response<Person>.fromJson(jsonMap, (json) =>
                Person.fromJson(json as Map<String, dynamic>)) as Response<T>;
        }
      },
    );
  }

  Future<Response<T>> searchMulti<T extends MediaTypeBase>({
        required String query,
        required int page,
        Locale? locale,
        required String apiKey,
      }) async {
    return _networkClient.makeRequest(
      RequestType.get,
      '/search/multi',
      urlParameters: <String, dynamic>{
        'api_key': apiKey,
        'query': query,
        'page': page.toString(),
        if (locale != null)
          'language': locale.languageCode,
      },
      parser: (dynamic json) {
        final jsonMap = json as Map<String, dynamic>;
        return Response<T>.fromJson(jsonMap, (json) {
          final jsonMap = json as Map<String, dynamic>;
          try {
            final mediaType = MediaType.values
                .singleWhere((e) => e.asString() == jsonMap['media_type']);
            switch (mediaType) {
              case MediaType.movie:
                return Movie.fromJson(jsonMap) as T;
              case MediaType.tv:
                return TV.fromJson(jsonMap) as T;
              case MediaType.person:
                return Person.fromJson(jsonMap) as T;
            }
          } on StateError {
            throw TypeError();
          }
        });
      },
    );
  }

  Future<Response<T>> getPopular<T extends MediaTypeBase>(
      MediaType mediaType, {
        required int page,
        Locale? locale,
        required String apiKey,
      }) async {
    return _networkClient.makeRequest(
      RequestType.get,
      '/${mediaType.asString()}/popular',
      urlParameters: <String, dynamic>{
        'api_key': apiKey,
        'page': page.toString(),
        if (locale != null)
          'language': locale.languageCode,
      },
      parser: (dynamic json) {
        final jsonMap = json as Map<String, dynamic>;
        switch (mediaType) {
          case MediaType.movie:
            return Response<Movie>.fromJson(jsonMap, (json) =>
                Movie.fromJson(json as Map<String, dynamic>)) as Response<T>;
          case MediaType.tv:
            return Response<TV>.fromJson(jsonMap, (json) =>
                TV.fromJson(json as Map<String, dynamic>))  as Response<T>;
          case MediaType.person:
            return Response<Person>.fromJson(jsonMap, (json) =>
                Person.fromJson(json as Map<String, dynamic>)) as Response<T>;
        }
      },
    );
  }

  Future<T> getDetails<T extends MediaTypeBase>(
      MediaType mediaType, {
        required int id,
        required String sessionId,
        Locale? locale,
        required String apiKey,
      }) async {
    final appendToResponse = <String>{};
    switch (mediaType) {
      case MediaType.movie:
        appendToResponse.addAll([
          'credits',
          'videos',
          'account_states',
          'release_dates',
        ]);
        break;
      case MediaType.tv:
        appendToResponse.addAll([
          'credits',
          'videos',
          'account_states',
          'content_ratings',
        ]);
        break;
      case MediaType.person:
        appendToResponse.addAll([
          'combined_credits',
          'external_ids',
        ]);
        break;
    }
    return _networkClient.makeRequest(
      RequestType.get,
      '/${mediaType.asString()}/$id',
      urlParameters: <String, dynamic>{
        'api_key': apiKey,
        'session_id': sessionId,
        if (locale != null)
          'language': locale.languageCode,
        'append_to_response': appendToResponse.join(','),
      },
      parser: (dynamic json) {
        final jsonMap = json as Map<String, dynamic>;
        switch (mediaType) {
          case MediaType.movie:
            return MovieDetails.fromJson(jsonMap) as T;
          case MediaType.tv:
            return TVDetails.fromJson(jsonMap) as T;
          case MediaType.person:
            return PersonDetails.fromJson(jsonMap) as T;
        }
      },
    );
  }


}
