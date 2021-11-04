import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/domain/api_client/image_downloader.dart';
import 'package:themoviedb/domain/entity/content_type.dart';
import 'package:themoviedb/resources/resources.dart';
import 'package:themoviedb/ui/theme/app_colors.dart';
import 'package:themoviedb/ui/widgets/content_details/content_details_model.dart';
import 'package:themoviedb/ui/widgets/elements/account_state_button_widget.dart';
import 'package:themoviedb/ui/widgets/elements/app_tooltip_widget.dart';
import 'package:themoviedb/ui/widgets/elements/content_rating_button_widget.dart';

class ContentDetailsTopPosterWidget<M extends ContentDetailsModel> extends StatelessWidget {
  const ContentDetailsTopPosterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final details = context.select((M model) => model.details!);
    final backdropPath = details.backdropPath ?? '';
    final posterPath = details.posterPath ?? '';

    return Stack(
      children: [
        if (backdropPath.isNotEmpty) ...[
          DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topCenter,
                colors: [
                  AppColors.mainDarkBlue,
                  Colors.transparent,
                ],
              ),
            ),
            position: DecorationPosition.foreground,
            child: Image.network(ImageDownloader.makeUrl(backdropPath)),
          ),
          Positioned(
            top: 20,
            left: 20,
            bottom: 20,
            child: _SmallPosterWidget(posterPath: posterPath),
          ),
        ],
        if (backdropPath.isEmpty)
          Container(
            height: 235,
            padding: const EdgeInsets.symmetric(vertical: 20),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.mainDarkBlue,
                  Colors.white,
                ],
              ),
            ),
            child: _SmallPosterWidget(posterPath: posterPath),
          ),
        Positioned(
          bottom: 0,
          right: 0,
          child: _AccountStateButtonBarWidget<M>(),
        ),
      ],
    );
  }
}

class _SmallPosterWidget extends StatelessWidget {
  const _SmallPosterWidget({
    Key? key,
    required this.posterPath,
  }) : super(key: key);

  final String posterPath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: posterPath.isEmpty
          ? Image.asset(AppImages.posterPlaceholder)
          : Image.network(ImageDownloader.makeUrl(posterPath)),
    );
  }
}

class _AccountStateButtonBarWidget<M extends ContentDetailsModel> extends StatelessWidget {
  const _AccountStateButtonBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<M>();
    final contentDetails = model.details!;

    return ButtonBar(
      buttonPadding: const EdgeInsets.all(3),
      children: [
        AppTooltipWidget(
          message: contentDetails.accountStates.isFavorite
              ? 'Remove from your favorite list'
              : 'Add to your favorite list',
          child: AccountStateButtonWidget(
            onPressed: () => model.toggleAccountState(
              contentDetails.mediaType,
              AccountState.isFavorite,
            ),
            state: contentDetails.accountStates.isFavorite,
            trueStateColor: Colors.pinkAccent,
            icon: Icons.favorite,
          ),
        ),

        AppTooltipWidget(
          message: contentDetails.accountStates.inWatchlist
              ? 'Remove from your watchlist'
              : 'Add to your watchlist',
          child: AccountStateButtonWidget(
            onPressed: () => model.toggleAccountState(
              contentDetails.mediaType,
              AccountState.inWatchlist,
            ),
            state: contentDetails.accountStates.inWatchlist,
            trueStateColor: Colors.redAccent,
            icon: Icons.bookmark,
          ),
        ),

        AppTooltipWidget(
          message: 'Rating',
          child: const ContentRatingButtonWidget(),
        ),
      ],
    );
  }
}
