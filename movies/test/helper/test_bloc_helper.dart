import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/presentation/bloc/movie/movies_bloc.dart';

class NowPlayingMoviesEventHelper extends Fake implements MovieBlocEvent {}

class NowPlayingMoviesStateHelper extends Fake implements MovieBlocState {}

class NowPlayingMoviesBlocHelper
    extends MockBloc<MovieBlocEvent, MovieBlocState>
    implements NowPlayingMoviesBloc {}

class PopularMoviesEventHelper extends Fake implements MovieBlocEvent {}

class PopularMoviesStateHelper extends Fake implements MovieBlocState {}

class PopularMoviesBlocHelper extends MockBloc<MovieBlocEvent, MovieBlocState>
    implements PopularMoviesBloc {}

class TopRatedMoviesEventHelper extends Fake implements MovieBlocEvent {}

class TopRatedMoviesStateHelper extends Fake implements MovieBlocState {}

class TopRatedMoviesBlocHelper extends MockBloc<MovieBlocEvent, MovieBlocState>
    implements TopRatedMoviesBloc {}

class MovieDetailEventHelper extends Fake implements MovieBlocEvent {}

class MovieDetailStateHelper extends Fake implements MovieBlocState {}

class MovieDetailBlocHelper extends MockBloc<MovieBlocEvent, MovieBlocState>
    implements DetailMovieBloc {}

class RecommendationsMovieEventHelper extends Fake implements MovieBlocEvent {}

class RecommendationsMovieStateHelper extends Fake implements MovieBlocState {}

class RecommendationsMovieBlocHelper
    extends MockBloc<MovieBlocEvent, MovieBlocState>
    implements RecommendationMovieBloc {}

class WatchlistMovieEventHelper extends Fake implements MovieBlocEvent {}

class WatchlistMovieStateHelper extends Fake implements MovieBlocState {}

class WatchlistMovieBlocHelper extends MockBloc<MovieBlocEvent, MovieBlocState>
    implements WatchListBloc {}
