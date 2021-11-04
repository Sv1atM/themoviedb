import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/domain/api_client/image_downloader.dart';
import 'package:themoviedb/domain/entity/person.dart';
import 'package:themoviedb/resources/resources.dart';
import 'package:themoviedb/ui/theme/app_text_styles.dart';
import 'package:themoviedb/ui/widgets/content_details/content_details_model.dart';
import 'package:themoviedb/ui/widgets/content_details/movie_details_model.dart';
import 'package:themoviedb/ui/widgets/content_details/tv_details_model.dart';
import 'package:themoviedb/ui/widgets/elements/app_scrollbar_widget.dart';
import 'package:themoviedb/ui/widgets/elements/tappable_widget.dart';
import 'package:themoviedb/ui/widgets/text_painter.dart';

class ContentDetailsMainScreenCastWidget<M extends ContentDetailsModel> extends StatelessWidget {
  const ContentDetailsMainScreenCastWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<M>();
    final cast = model.details!.credits.cast;
    final listTitle = _getListTitle();

    return ColoredBox(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(listTitle,
              style: AppTextStyles.em(1.2, fontWeight: FontWeight.bold),
            ),
          ),
          if (cast.isNotEmpty) ...[
            _CastWidget<M>(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
              child: TextButton(
                onPressed: model.openCastAndCrew,
                child: Text('Full Cast & Crew', style: AppTextStyles.em(1.1)),
              ),
            ),
          ],
          if (cast.isEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 20),
              child: Text('Empty', style: AppTextStyles.em(1.1)),
            ),
        ],
      ),
    );
  }

  String _getListTitle() {
    switch (M) {
      case MovieDetailsModel:
        return 'Top Billed Cast';
      case TVDetailsModel:
        return 'Series Cast';
      default:
        throw TypeError();
    }
  }
}

class _CastWidget<M extends ContentDetailsModel> extends StatefulWidget {
  const _CastWidget({Key? key}) : super(key: key);

  @override
  _CastWidgetState<M> createState() => _CastWidgetState<M>();
}

class _CastWidgetState<M extends ContentDetailsModel> extends State<_CastWidget> {
  @override
  Widget build(BuildContext context) {
    const maxActorCount = 9;
    final cast = context.select((M model) => model.details!.credits.cast);
    final itemCount = (cast.length > maxActorCount) ? maxActorCount + 1 : cast.length;
    final maxTextHeight = cast.take(maxActorCount).map(_getTextHeight).reduce(max);

    return SizedBox(
      height: 170 + maxTextHeight,
      child: AppScrollbarWidget(
        child: ListView.separated(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 15,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: itemCount,
          itemBuilder: (context, index) => SizedBox(
            width: 120,
            child: (index == maxActorCount)
                ? _ViewMoreButtonWidget<M>()
                : _ActorListItemWidget<M>(actor: cast[index]),
          ),
          separatorBuilder: (context, index) => const SizedBox(width: 15),
        ),
      ),
    );
  }

  double _getTextHeight(Actor actor) {
    const layoutWidth = 100.0;
    final nameTextHeight = textPainter(
      textWidget: Text(actor.name,
        style: AppTextStyles.em(1, fontWeight: FontWeight.bold),
      ),
      layoutWidth: layoutWidth,
    ).height;
    final characterTextHeight = textPainter(
      textWidget: Text(actor.character,
        style: AppTextStyles.em(0.9),
      ),
      layoutWidth: layoutWidth,
    ).height;
    return nameTextHeight + characterTextHeight;
  }
}

class _ActorListItemWidget<M extends ContentDetailsModel> extends StatelessWidget {
  const _ActorListItemWidget({
    Key? key,
    required this.actor,
  }) : super(key: key);

  final Actor actor;

  @override
  Widget build(BuildContext context) {
    final model = context.read<M>();

    return Stack(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            clipBehavior: Clip.hardEdge,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 0.9,
                  child: (actor.profilePath?.isNotEmpty ?? false)
                      ? Image.network(ImageDownloader.makeUrl(actor.profilePath!),
                    fit: BoxFit.fitWidth,
                    alignment: const Alignment(0, -0.5))
                      : Image.asset(AppImages.profilePlaceholder,
                    fit: BoxFit.fitHeight),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(actor.name,
                        style: AppTextStyles.em(1, fontWeight: FontWeight.bold),
                      ),
                      Text(actor.character,
                        style: AppTextStyles.em(0.9),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        TappableWidget(onTap: () => model.onPersonTap(actor.id)),
      ],
    );
  }
}

class _ViewMoreButtonWidget<M extends ContentDetailsModel> extends StatelessWidget {
  const _ViewMoreButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<M>();

    return InkWell(
      onTap: model.openCastAndCrew,
      child: Row(
        children: [
          Flexible(
            child: Text('View More',
              style: AppTextStyles.em(1, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 5),
          const Icon(Icons.arrow_forward, color: Colors.black),
        ],
      ),
    );
  }
}
