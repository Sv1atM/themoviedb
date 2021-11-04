import 'package:flutter/material.dart';
import 'package:themoviedb/ui/widgets/elements/loading_progress_indicator_widget.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: LoadingProgressIndicatorWidget()),
    );
  }
}
