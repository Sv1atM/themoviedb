import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/data_providers/locale_provider.dart';
import 'package:themoviedb/domain/entity/media_type_base.dart';
import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/domain/entity/person.dart';
import 'package:themoviedb/domain/entity/tv.dart';
import 'package:themoviedb/domain/services/media_service.dart';
import 'package:themoviedb/library/paginator.dart';
import 'package:themoviedb/library/response.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class MediaListModel<T extends MediaTypeBase> with ChangeNotifier {
  MediaListModel(this._context) {
    switch (T) {
      case Movie:
        _mediaType = MediaType.movie;
        break;
      case TV:
        _mediaType = MediaType.tv;
        break;
      case Person:
        _mediaType = MediaType.person;
        break;
      default:
        _mediaType = MediaType.movie;
        break;
    }
    _paginator = Paginator<T>(loadContent);
  }

  final _mediaService = MediaService();
  final _localeProvider = LocaleProvider();
  final BuildContext _context;
  late final Paginator<T> _paginator;
  late DateFormat _dateFormat;

  late MediaType _mediaType;
  MediaType get mediaType => _mediaType;

  Locale get locale => _localeProvider.locale;

  List<T> get mediaList => _paginator.data;

  Future<void> openDetails(T media) {
    return Navigator.of(_context).pushNamed(
      media.mediaType.routeToDetails,
      arguments: media.id,
    );
  }

  String? formattedDateString(DateTime? date) =>
      (date != null) ? _dateFormat.format(date) : null;

  Future<void> setupLocale(Locale locale) async {
    if (_localeProvider.updateLocale(locale)) {
      _dateFormat = DateFormat.yMMMMd(locale.toLanguageTag());
      await resetList();
    }
  }

  Future<void> loadNextPage() async {
    await _paginator.loadNextPage();
    notifyListeners();
  }

  @protected
  Future<void> resetList() async {
    await _paginator.resetList();
    notifyListeners();
  }

  @protected
  Future<Response<T>?> loadContent(int page) async {
    return _mediaService.getPopular(
      mediaType,
      page: page,
      locale: locale,
    );
  }
}
