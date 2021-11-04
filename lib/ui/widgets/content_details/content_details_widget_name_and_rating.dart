import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/ui/theme/app_text_styles.dart';
import 'package:themoviedb/ui/widgets/content_details/content_details_model.dart';
import 'package:themoviedb/ui/widgets/elements/user_score_widget.dart';

class ContentDetailsNameAndRatingWidget<M extends ContentDetailsModel> extends StatelessWidget {
  const ContentDetailsNameAndRatingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _NameWidget<M>(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: _RatingAndTrailerWidget<M>(),
        ),
      ],
    );
  }
}

class _NameWidget<M extends ContentDetailsModel> extends StatelessWidget {
  const _NameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final details = context.select((M model) => model.details!);
    final year = details.firstReleaseDate?.year;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: RichText(
        textAlign: TextAlign.center,
        maxLines: null,
        text: TextSpan(
          children: [
            TextSpan(text: details.name,
              style: AppTextStyles.em(1.5,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            if (year != null)
              TextSpan(text: ' ($year)',
                style: AppTextStyles.em(1.2, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}

class _RatingAndTrailerWidget<M extends ContentDetailsModel> extends StatelessWidget {
  const _RatingAndTrailerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<M>();
    final details = model.details!;
    final trailerKey = model.getTrailerKey();

    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UserScoreWidget(
                voteAverage: details.voteAverage,
                radius: 22,
              ),
              const SizedBox(width: 10),
              Text('User Score',
                style: AppTextStyles.em(1,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        if (trailerKey?.isNotEmpty ?? false) ...[
          ColoredBox(
            color: Colors.white.withOpacity(0.25),
            child: const SizedBox(
              width: 1,
              height: AppTextStyles.mainFontSize * 1.5,
            ),
          ),
          Expanded(
            flex: 4,
            child: TextButton.icon(
              onPressed: () => model.playTrailer(trailerKey!),
              icon: const Icon(Icons.play_arrow,
                size: AppTextStyles.mainFontSize,
                color: Colors.white,
              ),
              label: Text('Play Trailer',
                style: AppTextStyles.em(1, color: Colors.white),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
