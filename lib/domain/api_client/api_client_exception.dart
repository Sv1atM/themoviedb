enum ApiClientExceptionType { network, auth, sessionExpired, other }

extension ApiClientExceptionMessage on ApiClientExceptionType {
  String get message {
    switch (this) {
      case ApiClientExceptionType.network:
        return 'Server is unavailable. Check your Internet connection.';
      case ApiClientExceptionType.auth:
        return "We couldn't validate your information. Want to try again?";
      case ApiClientExceptionType.sessionExpired:
        return 'Session is expired. Please, log in to your account again.';
      case ApiClientExceptionType.other:
        return 'An error occurred. Please, try again.';
    }
  }
}

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}
