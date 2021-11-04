import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client/api_client_exception.dart';
import 'package:themoviedb/domain/api_client/web_page_launcher.dart';
import 'package:themoviedb/domain/services/auth_service.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';
import 'package:themoviedb/ui/widgets/dialogs/email_verification_widget.dart';
import 'package:themoviedb/ui/widgets/dialogs/password_reset_widget.dart';

class AuthModel with ChangeNotifier {
  AuthModel(this._context);

  final _authService = AuthService();
  final BuildContext _context;
  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  Future<void> resetPassword() async {
    return showDialog<void>(
      context: _context,
      builder: (_) => const PasswordResetWidget(),
    );
  }

  Future<void> verifyEmail() async {
    return showDialog<void>(
      context: _context,
      builder: (_) => const EmailVerificationWidget(),
    );
  }

  Future<void> signUp() async => WebPageLauncher.signUp();

  Future<void> auth() async {
    final login = loginTextController.text;
    final password = passwordTextController.text;
    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();
    _errorMessage = await _login(login, password);
    _isAuthProgress = false;
    if (_errorMessage != null) {
      notifyListeners();
    } else {
      MainNavigation.resetNavigation(_context);
    }
  }

  Future<String?> _login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) return ApiClientExceptionType.auth.message;
    try {
      await _authService.login(username, password);
    } on ApiClientException catch (e) {
      return e.type.message;
    } on Exception {
      return ApiClientExceptionType.other.message;
    }
  }
}
