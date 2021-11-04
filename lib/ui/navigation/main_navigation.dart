import 'package:flutter/material.dart';
import 'package:themoviedb/domain/entity/content_type.dart';
import 'package:themoviedb/domain/entity/media_type_base.dart';
import 'package:themoviedb/domain/factories/screen_factory.dart';
import 'package:themoviedb/ui/widgets/content_details/movie_details_model.dart';
import 'package:themoviedb/ui/widgets/content_details/tv_details_model.dart';

extension MediaDetailsRoute on MediaType {
  String get routeToDetails {
    switch (this) {
      case MediaType.movie:
        return MainNavigationRouteNames.movieDetails;
      case MediaType.tv:
        return MainNavigationRouteNames.tvDetails;
      case MediaType.person:
        return MainNavigationRouteNames.personDetails;
    }
  }
}

abstract class MainNavigationRouteNames {
  static const loader = '/';
  static const auth = '/auth';
  static const mainScreen = '/main';
  static const movieDetails = '/main/movie_details';
  static const movieCastAndCrew = '/main/movie_details/cast_and_crew';
  static const tvDetails = '/main/tv_details';
  static const tvCastAndCrew = '/main/tv_details/cast_and_crew';
  static const personDetails = '/main/person_details';
  static const accountStates = '/main/account_states';
}

class MainNavigation {
  static final _screenFactory = ScreenFactory();

  static void resetNavigation(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(MainNavigationRouteNames.loader, (_) => false);
  }

  Route<Object> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case MainNavigationRouteNames.loader:
        return _initialScreenRoute(_screenFactory.loader());

      case MainNavigationRouteNames.auth:
        return _initialScreenRoute(_screenFactory.auth());

      case MainNavigationRouteNames.mainScreen:
        return _initialScreenRoute(_screenFactory.mainScreen());

      case MainNavigationRouteNames.movieDetails:
        final movieId = (args is int) ? args : throw ArgumentError();
        return _screenRoute(_screenFactory.movieDetails(movieId));

      case MainNavigationRouteNames.tvDetails:
        final tvShowId = (args is int) ? args : throw ArgumentError();
        return _screenRoute(_screenFactory.tvDetails(tvShowId));

      case MainNavigationRouteNames.personDetails:
        final personId = (args is int) ? args : throw ArgumentError();
        return _screenRoute(_screenFactory.personDetails(personId));

      case MainNavigationRouteNames.movieCastAndCrew:
        final model = (args is MovieDetailsModel) ? args : throw ArgumentError();
        return _screenRoute(_screenFactory.movieCastAndCrew(model));

      case MainNavigationRouteNames.tvCastAndCrew:
        final model = (args is TVDetailsModel) ? args : throw ArgumentError();
        return _screenRoute(_screenFactory.tvCastAndCrew(model));

      case MainNavigationRouteNames.accountStates:
        final state = (args is AccountState) ? args : throw ArgumentError();
        return _screenRoute(_screenFactory.accountStates(state));

      default:
        const widget = Text('Navigation error!!!');
        return _screenRoute(widget);
    }
  }

  MaterialPageRoute<T> _screenRoute<T>(Widget screen) {
    return MaterialPageRoute<T>(builder: (_) => screen);
  }

  PageRouteBuilder<T> _initialScreenRoute<T>(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => screen,
      transitionDuration: Duration.zero,
    );
  }
}
