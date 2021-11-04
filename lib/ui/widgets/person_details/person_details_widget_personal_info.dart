import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/ui/theme/app_text_styles.dart';
import 'package:themoviedb/ui/widgets/person_details/person_details_model.dart';

class PersonDetailsPersonalInfoWidget extends StatelessWidget {
  const PersonDetailsPersonalInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<PersonDetailsModel>();
    final details = model.personDetails!;
    final titleStyle = AppTextStyles.em(1, fontWeight: FontWeight.w600);
    final textStyle = AppTextStyles.em(1);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Personal Info',
            style: AppTextStyles.em(1.3, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Known For', style: titleStyle),
                    Text(details.knownFor, style: textStyle),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Known Credits', style: titleStyle),
                    Text(model.knownForGenerator().length.toString(), style: textStyle),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text('Gender', style: titleStyle),
          Text(details.gender, style: textStyle),
          if (details.birthday != null) ...[
            const SizedBox(height: 10),
            Text('Birthday', style: titleStyle),
            Text(model.formattedDateString(details.birthday)! +
                (details.deathday == null
                    ? ' (${DateTime.now().yearsSince(details.birthday!)} years old)'
                    : ''),
              style: textStyle,
            ),
            if (details.deathday != null) ...[
              const SizedBox(height: 10),
              Text('Day of Death', style: titleStyle),
              Text(model.formattedDateString(details.deathday)! +
                  ' (${details.deathday!.yearsSince(details.birthday!)} years old)',
                style: textStyle,
              ),
            ],
          ],
          if (details.placeOfBirth != null) ...[
            const SizedBox(height: 10),
            Text('Place of Birth', style: titleStyle),
            Text(details.placeOfBirth!, style: textStyle),
          ],
        ],
      ),
    );
  }
}
