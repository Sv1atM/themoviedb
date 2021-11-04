import 'package:flutter/material.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/domain/entity/content_type.dart';
import 'package:themoviedb/domain/services/auth_service.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class MainScreenModel {
  MainScreenModel(this._context);

  final _sessionDataProvider = SessionDataProvider();
  final _authService = AuthService();
  final BuildContext _context;

  ValueNotifier<String?> get username =>
      ValueNotifier(_sessionDataProvider.accountInfo?.username);

  Future<void> onSelectedMenuItem(int index) async {
    switch (index) {
      case 1:
        return _openAccountStatesList(AccountState.isFavorite);
      case 2:
        return _openAccountStatesList(AccountState.inWatchlist);
      case 3:
        await _authService.logout();
        return MainNavigation.resetNavigation(_context);
    }
  }

  Future<void> _openAccountStatesList(AccountState state) async {
    return Navigator.of(_context).pushNamed<void>(
      MainNavigationRouteNames.accountStates,
      arguments: state,
    );
  }
}
