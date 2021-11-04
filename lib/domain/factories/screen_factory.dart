import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/domain/entity/content_type.dart';
import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/domain/entity/person.dart';
import 'package:themoviedb/domain/entity/tv.dart';
import 'package:themoviedb/ui/widgets/account_state_list/account_state_list_combiner.dart';
import 'package:themoviedb/ui/widgets/account_state_list/account_state_list_model.dart';
import 'package:themoviedb/ui/widgets/account_state_list/account_state_list_widget.dart';
import 'package:themoviedb/ui/widgets/auth/auth_model.dart';
import 'package:themoviedb/ui/widgets/auth/auth_widget.dart';
import 'package:themoviedb/ui/widgets/content_details/content_details_widget.dart';
import 'package:themoviedb/ui/widgets/content_details/content_details_widget_full_cast_and_crew.dart';
import 'package:themoviedb/ui/widgets/content_details/movie_details_model.dart';
import 'package:themoviedb/ui/widgets/content_details/tv_details_model.dart';
import 'package:themoviedb/ui/widgets/loader/loader_model.dart';
import 'package:themoviedb/ui/widgets/loader/loader_widget.dart';
import 'package:themoviedb/ui/widgets/main_screen/main_screen_model.dart';
import 'package:themoviedb/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:themoviedb/ui/widgets/media_list/content_list_widget.dart';
import 'package:themoviedb/ui/widgets/media_list/media_list_model.dart';
import 'package:themoviedb/ui/widgets/media_list/people_list_widget.dart';
import 'package:themoviedb/ui/widgets/person_details/person_details_model.dart';
import 'package:themoviedb/ui/widgets/person_details/person_details_widget.dart';

class ScreenFactory {
  Widget loader() => Provider(
    create: (context) => LoaderModel(context),
    lazy: false,
    child: const LoaderWidget(),
  );

  Widget auth() => ChangeNotifierProvider(
    create: (context) => AuthModel(context),
    child: const AuthWidget(),
  );

  Widget mainScreen() => Provider(
    create: (context) => MainScreenModel(context),
    child: const MainScreenWidget(),
  );

  Widget movieList() => ChangeNotifierProvider(
    create: (context) => MediaListModel<Movie>(context),
    child: const ContentListWidget<Movie>(),
  );

  Widget tvList() => ChangeNotifierProvider(
    create: (context) => MediaListModel<TV>(context),
    child: const ContentListWidget<TV>(),
  );

  Widget peopleList() => ChangeNotifierProvider(
    create: (context) => MediaListModel<Person>(context),
    child: const PeopleListWidget(),
  );

  Widget movieDetails(int movieId) => ChangeNotifierProvider(
    create: (context) => MovieDetailsModel(movieId, context),
    child: const ContentDetailsWidget<MovieDetailsModel>(),
  );

  Widget movieCastAndCrew(MovieDetailsModel model) => ChangeNotifierProvider.value(
    value: model,
    child: const ContentDetailsFullCastAndCrewWidget<MovieDetailsModel>(),
  );

  Widget tvDetails(int tvId) => ChangeNotifierProvider(
    create: (context) => TVDetailsModel(tvId, context),
    child: const ContentDetailsWidget<TVDetailsModel>(),
  );

  Widget tvCastAndCrew(TVDetailsModel model) => ChangeNotifierProvider.value(
    value: model,
    child: const ContentDetailsFullCastAndCrewWidget<TVDetailsModel>(),
  );

  Widget personDetails(int personId) => ChangeNotifierProvider(
    create: (context) => PersonDetailsModel(personId, context),
    child: const PersonDetailsWidget(),
  );

  Widget accountStates(AccountState state) => MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) =>
          AccountStateListModel<Movie>(state, context),
      ),
      ChangeNotifierProvider(create: (context) =>
          AccountStateListModel<TV>(state, context),
      ),
      ChangeNotifierProxyProvider2(
        create: (context) => AccountStateListCombiner(
          state: state,
          movieList: context.read<AccountStateListModel<Movie>>(),
          tvList: context.read<AccountStateListModel<TV>>(),
        ),
        update: (
            BuildContext context,
            AccountStateListModel<Movie> movieList,
            AccountStateListModel<TV> tvList,
            AccountStateListCombiner? previous,
            ) => previous ?? AccountStateListCombiner(
          state: state,
          movieList: movieList,
          tvList: tvList,
        ),
      ),
    ],
    child: const AccountStateListWidget(),
  );
}
