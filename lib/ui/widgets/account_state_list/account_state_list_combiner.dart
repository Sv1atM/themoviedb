import 'package:flutter/material.dart';
import 'package:themoviedb/domain/entity/content_type.dart';
import 'package:themoviedb/domain/entity/media_type_base.dart';
import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/domain/entity/tv.dart';
import 'package:themoviedb/ui/widgets/account_state_list/account_state_list_model.dart';

class AccountStateListCombiner with ChangeNotifier {
  AccountStateListCombiner({
    required this.state,
    required this.movieList,
    required this.tvList,
  });

  final AccountState state;
  final AccountStateListModel<Movie> movieList;
  final AccountStateListModel<TV> tvList;

  MediaType _mediaType = MediaType.movie;
  MediaType get mediaType => _mediaType;

  List<ContentType> get mediaList {
    switch (mediaType) {
      case MediaType.movie:
        return movieList.mediaList;
      case MediaType.tv:
        return tvList.mediaList;
      default:
        return [];
    }
  }

  Future<void> openDetails(ContentType media) {
    switch (media.runtimeType) {
      case Movie:
        return movieList.openDetails(media as Movie);
      case TV:
        return tvList.openDetails(media as TV);
      default:
        throw TypeError();
    }
  }

  String? formattedDateString(DateTime? date) => movieList.formattedDateString(date);

  void resetMediaType(MediaType newValue) {
    if (_mediaType != newValue) {
      _mediaType = newValue;
      notifyListeners();
    }
  }

  Future<void> removeItemAt(int index) async {
    switch (mediaType) {
      case MediaType.movie:
        await movieList.removeItemAt(index);
        break;
      case MediaType.tv:
        await tvList.removeItemAt(index);
        break;
      default:
        return;
    }
    notifyListeners();
  }

  Future<void> setupLocale(Locale locale) async {
    switch (mediaType) {
      case MediaType.movie:
        await movieList.setupLocale(locale);
        break;
      case MediaType.tv:
        await tvList.setupLocale(locale);
        break;
      default:
        return;
    }
    notifyListeners();
  }

  Future<void> loadNextPage() async {
    switch (mediaType) {
      case MediaType.movie:
        await movieList.loadNextPage();
        break;
      case MediaType.tv:
        await tvList.loadNextPage();
        break;
      default:
        return;
    }
    notifyListeners();
  }
}
