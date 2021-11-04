import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/domain/api_client/image_downloader.dart';
import 'package:themoviedb/resources/resources.dart';
import 'package:themoviedb/ui/theme/app_text_styles.dart';
import 'package:themoviedb/ui/widgets/elements/app_scrollbar_widget.dart';
import 'package:themoviedb/ui/widgets/elements/tappable_widget.dart';
import 'package:themoviedb/ui/widgets/person_details/person_details_model.dart';

class PersonDetailsKnownForWidget extends StatelessWidget {
  const PersonDetailsKnownForWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<PersonDetailsModel>();
    final knownFor = model.knownForGenerator().toList();

    if (knownFor.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: Text('Known For',
            style: AppTextStyles.em(1.3, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 290,
          child: AppScrollbarWidget(
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: knownFor.length,
                itemBuilder: (context, index) {
                  final item = knownFor[index];

                  return SizedBox(
                    width: 130,
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AspectRatio(
                              aspectRatio: 0.67,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                clipBehavior: Clip.hardEdge,
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: (item.posterPath?.isNotEmpty ?? false)
                                      ? Image.network(ImageDownloader.makeUrl(item.posterPath!))
                                      : Image.asset(AppImages.posterPlaceholder),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 7,
                              ),
                              child: Text(item.name,
                                style: AppTextStyles.em(1),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        TappableWidget(onTap: () => model.openDetails(index)),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 10),
            ),
          ),
        ),
      ],
    );
  }
}
