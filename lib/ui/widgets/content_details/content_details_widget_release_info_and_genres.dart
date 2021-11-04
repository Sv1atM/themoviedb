import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/ui/theme/app_text_styles.dart';
import 'package:themoviedb/ui/widgets/content_details/content_details_model.dart';
import 'package:themoviedb/ui/widgets/content_details/movie_details_model.dart';
import 'package:themoviedb/ui/widgets/content_details/tv_details_model.dart';

class ContentDetailsReleaseInfoAndGenresWidget<M extends ContentDetailsModel> extends StatelessWidget {
  const ContentDetailsReleaseInfoAndGenresWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          border: Border.all(color: Colors.black.withOpacity(0.25)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _ReleaseInfoWidget<M>(),
              _GenresWidget<M>(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReleaseInfoWidget<M extends ContentDetailsModel> extends StatelessWidget {
  const _ReleaseInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<M>();
    final String certification;
    final String releaseString;
    switch (M) {
      case MovieDetailsModel:
        certification = (model as MovieDetailsModel).getCertification() ?? '';
        final release = model.getRelease();
        if (release == null) return const SizedBox.shrink();
        final country = release.countryCode;
        final releaseDate = model.formattedDateString(release.releases.first.releaseDate);
        releaseString = '$releaseDate ($country)';
        break;

      case TVDetailsModel:
        certification = (model as TVDetailsModel).getCertification() ?? '';
        releaseString = '';
        break;

      default:
        throw TypeError();
    }
    final runtime = model.details!.runtime ?? 0;
    final textStyle = AppTextStyles.em(1, color: Colors.white);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (certification.isNotEmpty) ...[
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.7)),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 5,
                right: 5,
                bottom: 2,
              ),
              child: Text(certification,
                style: AppTextStyles.em(1, color: Colors.white.withOpacity(0.7)),
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
        if (releaseString.isNotEmpty)
          Text(releaseString + '  ', style: textStyle),
        if (runtime > 0)
          Text('•  ' + [
            if (runtime ~/ 60 > 0) '${runtime ~/ 60}h',
            if (runtime % 60 > 0) '${runtime % 60}m',
          ].join(' '), style: textStyle),
      ],
    );
  }
}

class _GenresWidget<M extends ContentDetailsModel> extends StatelessWidget {
  const _GenresWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<M>();
    final genres = model.details!.genres.map((e) => e.name);

    if (genres.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(genres.join(', '),
        style: AppTextStyles.em(1, color: Colors.white),
        textAlign: TextAlign.center,
        maxLines: null,
      ),
    );
  }
}
