import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/domain/api_client/image_downloader.dart';
import 'package:themoviedb/domain/entity/person.dart';
import 'package:themoviedb/resources/resources.dart';
import 'package:themoviedb/ui/theme/app_text_styles.dart';
import 'package:themoviedb/ui/widgets/content_details/content_details_model.dart';
import 'package:themoviedb/ui/widgets/content_details/movie_details_model.dart';
import 'package:themoviedb/ui/widgets/content_details/tv_details_model.dart';
import 'package:themoviedb/ui/widgets/elements/tappable_widget.dart';

class ContentDetailsFullCastAndCrewWidget<M extends ContentDetailsModel> extends StatelessWidget {
  const ContentDetailsFullCastAndCrewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _TitleWidget<M>()),
      body: _CastAndCrewListWidget<M>(),
    );
  }
}

class _TitleWidget<M extends ContentDetailsModel> extends StatelessWidget {
  const _TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = context.read<M>().details!.name;
    return Text(title, overflow: TextOverflow.ellipsis);
  }
}

class _CastAndCrewListWidget<M extends ContentDetailsModel> extends StatelessWidget {
  const _CastAndCrewListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<M>();
    final credits = model.details!.credits;

    if (credits.cast.isNotEmpty) {
      return CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: _ListTitleWidget(
                title: _listTitle('Cast'),
                listItemCount: credits.cast.length,
                emTextSize: 1.2,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 10,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) => _ListItemWidget<M>(person: credits.cast[index]),
                childCount: credits.cast.length,
              ),
            ),
          ),

          if (model.crewGenerator().isNotEmpty) ...[
            SliverList(
              delegate: SliverChildListDelegate([
                const Divider(height: 1, color: Colors.grey),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: _ListTitleWidget(
                    title: _listTitle('Crew'),
                    listItemCount: model.crewGenerator().length,
                    emTextSize: 1.2,
                  ),
                ),
              ]),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 10,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) => _crewItemGenerator(context).elementAt(index),
                  childCount: _crewItemGenerator(context).length,
                ),
              ),
            ),
          ],
        ],
      );
    }
    return const SizedBox.shrink();
  }

  String _listTitle(String listName) {
    switch (M) {
      case MovieDetailsModel:
        return listName;
      case TVDetailsModel:
        return 'Series $listName';
      default:
        throw TypeError();
    }
  }

  Iterable<Widget> _crewItemGenerator(BuildContext context) sync* {
    final model = context.read<M>();
    var department = model.crewGenerator().first.department;
    yield Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 8),
      child: _ListTitleWidget(title: department, emTextSize: 1),
    );
    for (var person in model.crewGenerator()) {
      if (person.department != department) {
        department = person.department;
        yield Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 8),
          child: _ListTitleWidget(title: department, emTextSize: 1),
        );
      }
      yield _ListItemWidget<M>(person: person);
    }
  }
}

class _ListTitleWidget extends StatelessWidget {
  const _ListTitleWidget({
    Key? key,
    required this.title,
    this.listItemCount,
    required this.emTextSize,
  }) : super(key: key);

  final String title;
  final int? listItemCount;
  final double emTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title,
          style: AppTextStyles.em(emTextSize, fontWeight: FontWeight.bold),
        ),
        if (listItemCount != null) ...[
          const SizedBox(width: 5),
          Text(listItemCount.toString(),
            style: AppTextStyles.em(emTextSize,
              fontWeight: FontWeight.normal,
              color: Colors.black.withOpacity(0.6),
            ),
          ),
        ],
      ],
    );
  }
}

class _ListItemWidget<M extends ContentDetailsModel> extends StatelessWidget {
  const _ListItemWidget({
    Key? key,
    required this.person,
  }) : super(key: key);

  final Person person;

  @override
  Widget build(BuildContext context) {
    final model = context.read<M>();
    final job = _personJob();

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 66,
        child: Stack(
          children: [
            Row(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    clipBehavior: Clip.hardEdge,
                    child: (person.profilePath?.isEmpty ?? true)
                        ? Image.asset(AppImages.profilePlaceholder)
                        : Image.network(ImageDownloader.makeUrl(person.profilePath!),
                      fit: BoxFit.cover,
                      alignment: const Alignment(0, -0.5),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(person.name,
                          style: AppTextStyles.em(1, fontWeight: FontWeight.bold),
                      ),
                      if (job.isNotEmpty)
                        Text(job,
                          style: AppTextStyles.em(0.9),
                          maxLines: 2,
                        ),
                    ],
                  ),
                ),
              ],
            ),
            TappableWidget(onTap: () => model.onPersonTap(person.id)),
          ],
        ),
      ),
    );
  }

  String _personJob() {
    switch (person.runtimeType) {
      case Actor:
        return (person as Actor).character;
      case CrewMember:
        return (person as CrewMember).job;
      default:
        throw TypeError();
    }
  }
}
