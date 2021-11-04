import 'dart:convert';
import 'dart:io';

import 'package:themoviedb/configuration/network_configuration.dart';
import 'package:themoviedb/domain/api_client/api_client_exception.dart';

enum RequestType { get, post, delete }

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async => transform(utf8.decoder).join()
      .then<dynamic>(json.decode);
}

class NetworkClient {
  final _client = HttpClient();

  Future<T> makeRequest<T>(
      RequestType requestType,
      String path, {
        Map<String, dynamic>? urlParameters,
        Map<String, dynamic>? bodyParameters,
        required T Function(dynamic json) parser,
      }) async {
    try {
      final url = _makeUri(path, urlParameters);
      final HttpClientRequest request;
      switch (requestType) {
        case RequestType.get:
          request = await _client.getUrl(url);
          break;
        case RequestType.post:
          request = await _client.postUrl(url)
            ..headers.contentType = ContentType.json
            ..write(jsonEncode(bodyParameters));
          break;
        case RequestType.delete:
          request = await _client.deleteUrl(url)
            ..headers.contentType = ContentType.json
            ..write(jsonEncode(bodyParameters));
          break;
      }
      final response = await request.close();
      final dynamic json = await response.jsonDecode();
      _validateResponse(response, json);
      return parser(json);
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } on Exception {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    const host = NetworkConfiguration.host;
    final uri = Uri.parse(host + path).replace(queryParameters: parameters);
    return uri;
  }

  void _validateResponse(HttpClientResponse response, dynamic json) {
    if (response.statusCode == 401) {
      final dynamic status = json['status_code'];
      final code = status is int ? status : 0;
      switch (code) {
        case 3:
          throw ApiClientException(ApiClientExceptionType.sessionExpired);
        case 30:
          throw ApiClientException(ApiClientExceptionType.auth);
        default:
          throw ApiClientException(ApiClientExceptionType.other);
      }
    }
  }
}
