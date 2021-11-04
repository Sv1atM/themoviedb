import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/domain/api_client/image_downloader.dart';
import 'package:themoviedb/domain/api_client/web_page_launcher.dart';
import 'package:themoviedb/resources/app_icons.dart';
import 'package:themoviedb/resources/resources.dart';
import 'package:themoviedb/ui/theme/app_text_styles.dart';
import 'package:themoviedb/ui/widgets/elements/social_media_button_widget.dart';
import 'package:themoviedb/ui/widgets/person_details/person_details_model.dart';

class PersonDetailsAvatarAndSocialsWidget extends StatelessWidget {
  const PersonDetailsAvatarAndSocialsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final details = context.read<PersonDetailsModel>().personDetails!;
    final currentOrientation = MediaQuery.of(context).orientation;
    final isPortraitOrientation = currentOrientation == Orientation.portrait;
    final flex = isPortraitOrientation ? 2 : 4;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            children: [
              Spacer(flex: flex),
              Flexible(
                flex: 3,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: (details.profilePath?.isEmpty ?? true)
                        ? Image.asset(AppImages.profilePlaceholder)
                        : Image.network(ImageDownloader.makeUrl(details.profilePath!),
                      fit: BoxFit.fitWidth,
                      alignment: const Alignment(0, -0.5),
                    ),
                  ),
                ),
              ),
              Spacer(flex: flex),
            ],
          ),
        ),
        Text(details.name,
          style: AppTextStyles.em(2.2, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (details.socialIDs.facebook != null)
              SocialMediaButtonWidget(
                onPressed: () => WebPageLauncher.openFacebook(details.socialIDs.facebook!),
                icon: AppIcons.facebook,
              ),
            if (details.socialIDs.twitter != null)
              SocialMediaButtonWidget(
                onPressed: () => WebPageLauncher.openTwitter(details.socialIDs.twitter!),
                icon: AppIcons.twitter,
              ),
            if (details.socialIDs.instagram != null)
              SocialMediaButtonWidget(
                onPressed: () => WebPageLauncher.openInstagram(details.socialIDs.instagram!),
                icon: AppIcons.instagram,
              ),
            if (details.homepage != null)
              SocialMediaButtonWidget(
                onPressed: () => WebPageLauncher.openPage(details.homepage!),
                icon: AppIcons.homepage,
              ),
          ],
        ),
      ],
    );
  }
}
