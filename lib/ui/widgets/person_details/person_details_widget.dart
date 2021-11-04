import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/ui/widgets/elements/loading_progress_indicator_widget.dart';
import 'package:themoviedb/ui/widgets/person_details/person_details_model.dart';
import 'package:themoviedb/ui/widgets/person_details/person_details_widget_avatar_and_socials.dart';
import 'package:themoviedb/ui/widgets/person_details/person_details_widget_biography.dart';
import 'package:themoviedb/ui/widgets/person_details/person_details_widget_known_for.dart';
import 'package:themoviedb/ui/widgets/person_details/person_details_widget_personal_info.dart';

class PersonDetailsWidget extends StatefulWidget {
  const PersonDetailsWidget({Key? key}) : super(key: key);

  @override
  _PersonDetailsWidgetState createState() => _PersonDetailsWidgetState();
}

class _PersonDetailsWidgetState extends State<PersonDetailsWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    context.read<PersonDetailsModel>().setupLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const _TitleWidget()),
      body: const _BodyWidget(),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = context.select((PersonDetailsModel model) => model
        .personDetails?.name ?? 'Loading...');
    return Text(title, overflow: TextOverflow.ellipsis);
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PersonDetailsModel>();

    if (model.personDetails == null) return const LoadingProgressIndicatorWidget();

    return ListView(
      children: const [
        PersonDetailsAvatarAndSocialsWidget(),
        SizedBox(height: 30),
        PersonDetailsPersonalInfoWidget(),
        PersonDetailsBiographyWidget(),
        SizedBox(height: 30),
        PersonDetailsKnownForWidget(),
      ],
    );
  }
}
