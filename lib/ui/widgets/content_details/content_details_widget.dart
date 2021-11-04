import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/ui/theme/app_colors.dart';
import 'package:themoviedb/ui/widgets/content_details/content_details_model.dart';
import 'package:themoviedb/ui/widgets/content_details/content_details_widget_main_screen_cast.dart';
import 'package:themoviedb/ui/widgets/content_details/content_details_widget_name_and_rating.dart';
import 'package:themoviedb/ui/widgets/content_details/content_details_widget_overview_and_creators_list.dart';
import 'package:themoviedb/ui/widgets/content_details/content_details_widget_release_info_and_genres.dart';
import 'package:themoviedb/ui/widgets/content_details/content_details_widget_top_poster.dart';
import 'package:themoviedb/ui/widgets/elements/loading_progress_indicator_widget.dart';

class ContentDetailsWidget<M extends ContentDetailsModel> extends StatefulWidget {
  const ContentDetailsWidget({Key? key}) : super(key: key);

  @override
  _ContentDetailsWidgetState<M> createState() => _ContentDetailsWidgetState<M>();
}

class _ContentDetailsWidgetState<M extends ContentDetailsModel> extends State<ContentDetailsWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    context.read<M>().setupLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _TitleWidget<M>()),
      body: _BodyWidget<M>(),
    );
  }
}

class _TitleWidget<M extends ContentDetailsModel> extends StatelessWidget {
  const _TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = context.select((M model) => model.details?.name ?? 'Loading...');
    return Text(title, overflow: TextOverflow.ellipsis);
  }
}

class _BodyWidget<M extends ContentDetailsModel> extends StatelessWidget {
  const _BodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<M>();

    if (model.details == null) return const LoadingProgressIndicatorWidget();

    return ListView(
      children: [
        ColoredBox(
          color: AppColors.mainDarkBlue,
          child: Column(
            children: [
              ContentDetailsTopPosterWidget<M>(),
              const SizedBox(height: 20),
              ContentDetailsNameAndRatingWidget<M>(),
              ContentDetailsReleaseInfoAndGenresWidget<M>(),
              const SizedBox(height: 10),
              ContentDetailsOverviewAndCreatorsListWidget<M>(),
            ],
          ),
        ),
        const Divider(height: 1, color: Colors.grey),
        ContentDetailsMainScreenCastWidget<M>(),
      ],
    );
  }
}
