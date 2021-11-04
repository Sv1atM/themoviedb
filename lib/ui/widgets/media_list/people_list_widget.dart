import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/domain/api_client/image_downloader.dart';
import 'package:themoviedb/domain/entity/person.dart';
import 'package:themoviedb/resources/resources.dart';
import 'package:themoviedb/ui/theme/app_text_styles.dart';
import 'package:themoviedb/ui/widgets/elements/tappable_widget.dart';
import 'package:themoviedb/ui/widgets/media_list/media_list_model.dart';

class PeopleListWidget extends StatefulWidget {
  const PeopleListWidget({Key? key}) : super(key: key);

  @override
  State<PeopleListWidget> createState() => _PeopleListWidgetState();
}

class _PeopleListWidgetState extends State<PeopleListWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    context.read<MediaListModel<Person>>().setupLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MediaListModel<Person>>();
    final people = model.mediaList;
    final currentOrientation = MediaQuery.of(context).orientation;
    final isPortraitOrientation = currentOrientation == Orientation.portrait;

    return GridView.builder(
      key: people.isNotEmpty ? ObjectKey(people.first) : null,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isPortraitOrientation ? 2 : 3,
        crossAxisSpacing: 25,
        mainAxisSpacing: 25,
        childAspectRatio: 0.79,
      ),
      padding: const EdgeInsets.symmetric(vertical: 1),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: people.length,
      itemBuilder: (context, index) {
        if (index == people.length - 1) model.loadNextPage();
        return _PeopleListItemWidget(item: people[index]);
      },
    );
  }
}

class _PeopleListItemWidget extends StatelessWidget {
  const _PeopleListItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Person item;

  @override
  Widget build(BuildContext context) {
    final model = context.read<MediaListModel<Person>>();
    final profilePath = item.profilePath ?? '';

    return Stack(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: (profilePath.isEmpty)
                    ? Image.asset(AppImages.profilePlaceholder)
                    : Image.network(ImageDownloader.makeUrl(item.profilePath!),
                  fit: BoxFit.fitWidth,
                  alignment: const Alignment(0, -0.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name,
                      style: AppTextStyles.em(1, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(item.knownFor,
                      style: AppTextStyles.em(0.9, color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        TappableWidget(onTap: () => model.openDetails(item)),
      ],
    );
  }
}
