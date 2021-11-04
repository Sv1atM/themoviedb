import 'package:flutter/material.dart';
import 'package:themoviedb/ui/widgets/elements/secondary_option_button_widget.dart';

class CancelButtonWidget extends StatelessWidget {
  const CancelButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SecondaryOptionButtonWidget(
      onPressed: Navigator.of(context).pop,
      text: 'Cancel',
    );
  }
}
