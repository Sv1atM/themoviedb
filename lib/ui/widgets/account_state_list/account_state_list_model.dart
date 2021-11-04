import 'package:flutter/cupertino.dart';
import 'package:themoviedb/domain/api_client/api_client_exception.dart';
import 'package:themoviedb/domain/entity/content_type.dart';
import 'package:themoviedb/domain/services/auth_service.dart';
import 'package:themoviedb/domain/services/media_service.dart';
import 'package:themoviedb/library/response.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';
import 'package:themoviedb/ui/widgets/media_list/media_list_model.dart';

class AccountStateListModel<T extends ContentType> extends MediaListModel<T> {
  AccountStateListModel(this.state, this._context) : super(_context);

  final _mediaService = MediaService();
  final _authService = AuthService();
  final AccountState state;
  final BuildContext _context;

  Future<void> removeItemAt(int index) async {
    try {
      final mediaId = mediaList.removeAt(index).id;
      notifyListeners();
      return _mediaService.setAccountState(
        mediaType,
        state,
        mediaId: mediaId,
        newState: false,
      );
    } on ApiClientException catch (e) {
      _apiClientExceptionHandle(e);
    }
  }

  @override
  Future<Response<T>?> loadContent(int page) async {
    try {
      return _mediaService.getAccountStateList<T>(
        mediaType,
        state,
        page: page,
        locale: locale,
      );
    } on ApiClientException catch (e) {
      _apiClientExceptionHandle(e);
    }
  }

  void _apiClientExceptionHandle(ApiClientException exception) {
    switch (exception.type) {
      case ApiClientExceptionType.sessionExpired:
        _authService.logout();
        MainNavigation.resetNavigation(_context);
        return;
      default:
        throw exception;
    }
  }
}
