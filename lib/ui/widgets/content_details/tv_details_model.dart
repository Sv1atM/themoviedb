import 'package:flutter/material.dart';
import 'package:themoviedb/domain/entity/tv.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';
import 'package:themoviedb/ui/widgets/content_details/content_details_model.dart';

class TVDetailsModel extends ContentDetailsModel<TVDetails> {
  TVDetailsModel(int tvId, this._context) : super(tvId, _context);

  final BuildContext _context;

  @override
  Future<void> openCastAndCrew() async {
    return Navigator.of(_context).pushNamed<void>(
      MainNavigationRouteNames.tvCastAndCrew,
      arguments: this,
    );
  }

  @override
  Map<String, String> getCreators() {
    final creators = (details as TVDetails).createdBy;
    final map = { for (var creator in creators) creator.name: 'Creator' };
    return map;
  }

  @override
  String? getCertification() {
    final certificationList = (details as TVDetails).certifications.list;
    if (certificationList.isEmpty) return null;
    for (var country in { locale.countryCode, 'US' }) {
      try {
        return certificationList.firstWhere((e) => e.countryCode == country).rating;
      } on StateError {
        continue;
      }
    }
    return certificationList.firstWhere((certification) => certification.rating.isNotEmpty,
        orElse: () => certificationList.first).rating;
  }
}
