import 'dart:async';

import 'package:flutter/material.dart';
import 'package:themoviedb/domain/services/auth_service.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class LoaderModel {
  LoaderModel(this._context) {
    _checkAuth();
  }

  final _authService = AuthService();
  final BuildContext _context;

  Future<void> _checkAuth() async {
    final isAuth = await _authService.isAuth();
    final nextScreen = isAuth
        ? MainNavigationRouteNames.mainScreen
        : MainNavigationRouteNames.auth;
    return Navigator.of(_context).pushReplacementNamed<void, void>(nextScreen);
  }
}
