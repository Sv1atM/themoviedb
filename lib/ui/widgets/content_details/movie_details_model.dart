import 'package:flutter/material.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';
import 'package:themoviedb/ui/widgets/content_details/content_details_model.dart';
import 'package:themoviedb/domain/entity/movie.dart';


class MovieDetailsModel extends ContentDetailsModel<MovieDetails> {
  MovieDetailsModel(int movieId, this._context) : super(movieId, _context);

  final BuildContext _context;

  @override
  Future<void> openCastAndCrew() async {
    return Navigator.of(_context).pushNamed<void>(
      MainNavigationRouteNames.movieCastAndCrew,
      arguments: this,
    );
  }

  @override
  Map<String, String> getCreators() {
    final map = <String, String>{};
    details?.credits.crew
        .where((person) => (person.department == 'Directing' && person.job == 'Director')
        || (person.department == 'Writing' && person.job != 'Screenstory'))
        .forEach((person) => map[person.name] = map.containsKey(person.name)
        ? '${map[person.name]}, ${person.job}' : person.job);
    return map;
  }

  @override
  String? getCertification() {
    final releaseList = (details as MovieDetails).releaseDates.list;
    if (releaseList.isEmpty) return null;
    for (var country in { locale.countryCode, 'US', 'GB' }) {
      try {
        return releaseList
            .firstWhere((e) => e.countryCode == country).releases
            .firstWhere((e) => e.certification.isNotEmpty).certification;
      } on StateError {
        continue;
      }
    }
    final releases = releaseList.firstWhere(
            (release) => release.releases.any((e) => e.certification.isNotEmpty),
        orElse: () => releaseList.first).releases;
    return releases.firstWhere((e) => e.certification.isNotEmpty,
        orElse: () => releases.first).certification;
  }

  MovieRelease? getRelease() {
    final releaseList = (details as MovieDetails).releaseDates.list;
    if (releaseList.isEmpty) return null;
    for (var country in { locale.countryCode, 'US' }) {
      try {
        return releaseList.firstWhere((e) => e.countryCode == country);
      } on StateError {
        continue;
      }
    }
    releaseList.sort((one, other) {
      try {
        return one.releases.first.releaseDate!.compareTo(other.releases.first.releaseDate!);
      } on Error {
        return 0;
      }
    });
    return releaseList.first;
  }
}
