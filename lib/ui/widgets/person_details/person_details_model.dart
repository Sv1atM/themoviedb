import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client/api_client_exception.dart';
import 'package:themoviedb/domain/data_providers/locale_provider.dart';
import 'package:themoviedb/domain/entity/content_type.dart';
import 'package:themoviedb/domain/entity/media_type_base.dart';
import 'package:themoviedb/domain/entity/person.dart';
import 'package:themoviedb/domain/services/auth_service.dart';
import 'package:themoviedb/domain/services/media_service.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class PersonDetailsModel with ChangeNotifier {
  PersonDetailsModel(this._personId, this._context);

  final _mediaService = MediaService();
  final _authService = AuthService();
  final _localeProvider = LocaleProvider();
  final int _personId;
  final BuildContext _context;
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  Locale get locale => _localeProvider.locale;

  PersonDetails? _details;
  PersonDetails? get personDetails => _details;

  Future<void> openDetails(int index) {
    final content = knownForGenerator().elementAt(index);
    return Navigator.of(_context)
        .pushNamed(content.mediaType.routeToDetails, arguments: content.id);
  }

  String? formattedDateString(DateTime? date) =>
      (date != null) ? _dateFormat.format(date) : null;

  Future<void> setupLocale(Locale locale) async {
    if (_localeProvider.updateLocale(locale)) await loadDetails();
  }

  Future<void> loadDetails() async {
    try {
      _details = await _mediaService.getDetails<PersonDetails>(
        MediaType.person,
        id: _personId,
        locale: locale,
      );
      notifyListeners();
    } on ApiClientException catch (e) {
      _apiClientExceptionHandle(e);
    }
  }

  Iterable<CreditsInfo> knownForGenerator() sync* {
    if (_details != null) {
      final cast = _details!.credits.cast.where(_contentIsReleased);
      final crew = _details!.credits.crew.where((content) => _contentIsReleased(content)
          && !cast.any((cast) => cast.name == content.name));
      final knownFor = [ ...cast, ...crew ]..sort(_creditsInfoComparator);
      for (var content in knownFor) {
        yield content;
      }
    }
  }

  bool _contentIsReleased(CreditsInfo content) =>
      (content.firstReleaseDate?.compareTo(DateTime.now()) ?? 0) < 0;
  
  int _creditsInfoComparator(CreditsInfo one, CreditsInfo other) {
    if (one.firstReleaseDate == null) return -1;
    if (other.firstReleaseDate == null) return 1;
    return -one.firstReleaseDate!.compareTo(other.firstReleaseDate!);
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

extension AgeCalculator on DateTime {
  int yearsSince(DateTime date) {
    return (month >= date.month && day >= date.day)
        ? year - date.year
        : year - date.year - 1;
  }
}
