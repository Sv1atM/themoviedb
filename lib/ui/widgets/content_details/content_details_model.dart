import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client/api_client_exception.dart';
import 'package:themoviedb/domain/data_providers/locale_provider.dart';
import 'package:themoviedb/domain/entity/content_type.dart';
import 'package:themoviedb/domain/entity/media_type_base.dart';
import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/domain/entity/person.dart';
import 'package:themoviedb/domain/entity/tv.dart';
import 'package:themoviedb/domain/services/auth_service.dart';
import 'package:themoviedb/domain/services/media_service.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';
import 'package:themoviedb/ui/widgets/dialogs/youtube_player_widget.dart';

abstract class ContentDetailsModel<T extends ContentDetails> with ChangeNotifier {
  ContentDetailsModel(this._contentId, this._context);

  final _mediaService = MediaService();
  final _authService = AuthService();
  final _localeProvider = LocaleProvider();
  final int _contentId;
  final BuildContext _context;
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  Locale get locale => _localeProvider.locale;

  T? _details;
  T? get details => _details;

  Future<void> onPersonTap(int personId) async {
    return Navigator.of(_context).pushNamed<void>(
      MainNavigationRouteNames.personDetails,
      arguments: personId,
    );
  }

  Future<void> openCastAndCrew();

  Map<String, String> getCreators();

  String? getCertification();

  String? formattedDateString(DateTime? date) =>
      (date != null) ? _dateFormat.format(date) : null;

  Future<void> setupLocale(Locale locale) async {
    if (_localeProvider.updateLocale(locale)) await loadDetails();
  }

  Future<void> playTrailer(String trailerKey) async {
    return showDialog<void>(
      context: _context,
      builder: (_) => YouTubePlayerWidget(videoId: trailerKey),
    );
  }

  String? getTrailerKey() {
    final trailers = _details?.videos.list
        .where((video) => video.type == 'Trailer' && video.site == 'YouTube').toList()
      ?..sort((_, trailer) => trailer.official ? 1 : -1);
    return (trailers?.isNotEmpty ?? false) ? trailers?.first.key : null;
  }

  Future<void> loadDetails() async {
    final MediaType mediaType;
    switch (T) {
      case MovieDetails:
        mediaType = MediaType.movie;
        break;
      case TVDetails:
        mediaType = MediaType.tv;
        break;
      default:
        throw TypeError();
    }
    try {
      _details = await _mediaService.getDetails<T>(
        mediaType,
        id: _contentId,
        locale: locale,
      );
      notifyListeners();
    } on ApiClientException catch (e) {
      _apiClientExceptionHandle(e);
    }
  }

  Future<void> toggleAccountState(MediaType mediaType, AccountState state) async {
    if (_details == null) return;
    final bool newState;
    switch (state) {
      case AccountState.isFavorite:
        newState = !_details!.accountStates.isFavorite;
        _details!.accountStates.isFavorite = newState;
        break;
      case AccountState.inWatchlist:
        newState = !_details!.accountStates.inWatchlist;
        _details!.accountStates.inWatchlist = newState;
        break;
    }
    notifyListeners();
    try {
      await _mediaService.setAccountState(
        mediaType,
        state,
        mediaId: _contentId,
        newState: newState,
      );
    } on ApiClientException catch (e) {
      _apiClientExceptionHandle(e);
    }
  }

  Iterable<CrewMember> crewGenerator() sync* {
    if (_details == null) return;
    final departments = SplayTreeSet<String>
        .from(_details!.credits.crew.map<String>((e) => e.department));
    for (var department in departments) {
      final crew = _details!.credits.crew.where((e) => e.department == department).toList()
        ..sort(_crewMemberComparator);
      final names = crew.map<String>((e) => e.name).toSet();
      for (var name in names) {
        final person = crew.firstWhere((e) => e.name == name);
        final jobs = crew.where((e) => e.name == name).map((e) => e.job);
        yield CrewMember(
          id: person.id,
          name: person.name,
          profilePath: person.profilePath,
          knownForDepartment: person.knownForDepartment,
          department: person.department,
          job: jobs.join(', '),
        );
      }
    }
  }

  int _crewMemberComparator(CrewMember one, CrewMember other) {
    var result = one.department.compareTo(other.department);
    if (result != 0) return result;
    result = one.job.compareTo(other.job);
    return (result != 0) ? result : one.name.compareTo(other.name);
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
