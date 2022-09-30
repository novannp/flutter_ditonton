import 'package:core/core.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/datasources/tv_local_data_source.dart';
import 'package:core/data/datasources/tv_remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tv_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:core/domain/usecases/movie_usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/tv_usecases/get_on_the_air_tv.dart';
import 'package:core/domain/usecases/movie_usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/movie_usecases/get_movie_recommendations.dart';
import 'package:core/domain/usecases/movie_usecases/get_now_playing_movies.dart';
import 'package:core/domain/usecases/movie_usecases/get_popular_movies.dart';
import 'package:core/domain/usecases/tv_usecases/get_popular_tv.dart';
import 'package:core/domain/usecases/movie_usecases/get_top_rated_movies.dart';
import 'package:core/domain/usecases/tv_usecases/get_top_rated_tv.dart';
import 'package:core/domain/usecases/tv_usecases/get_tv_detail.dart';
import 'package:core/domain/usecases/tv_usecases/get_tv_recommendation.dart';
import 'package:core/domain/usecases/movie_usecases/get_watchlist_movies.dart';
import 'package:core/domain/usecases/movie_usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/tv_usecases/get_watchlist_tv.dart';
import 'package:core/domain/usecases/tv_usecases/get_watchlist_tv_status.dart';
import 'package:core/domain/usecases/tv_usecases/remove_tv_watchlist.dart';

import 'package:core/domain/usecases/tv_usecases/save_tv_watchlist.dart';
import 'package:core/domain/usecases/movie_usecases/save_watchlist.dart';

import 'package:core/presentation/bloc/movie/movies_bloc.dart';

import 'package:get_it/get_it.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tv.dart';
import 'package:search/presentation/bloc/search_movies_bloc.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => SearchMoviesBloc(locator()));
  locator.registerFactory(() => NowPlayingMoviesBloc(locator()));
  locator.registerFactory(() => PopularMoviesBloc(locator()));
  locator.registerFactory(() => TopRatedMoviesBloc(locator()));
  locator.registerFactory(() => DetailMovieBloc(locator()));
  locator.registerFactory(() => RecommendationMovieBloc(locator()));
  locator.registerFactory(() => WatchListBloc(
        locator(),
        locator(),
        locator(),
        locator(),
      ));

  // TV BLoC
  locator.registerFactory(() => SearchTvBloc(locator()));
  locator.registerFactory(() => OnTheAirNowBloc(locator()));
  locator.registerFactory(() => PopularTvBloc(locator()));
  locator.registerFactory(() => TopRatedTvBloc(locator()));
  locator.registerFactory(() => TvDetailBloc(locator()));
  locator.registerFactory(() => RecommendationTvBloc(locator()));
  locator.registerFactory(() => WatchlistTvBloc(
        locator(),
        locator(),
        locator(),
        locator(),
      ));

  // provider

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetOnTheAirTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecomendation(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => GetWatchListTv(locator()));
  locator.registerLazySingleton(() => GetWatchListTvStatus(locator()));
  locator.registerLazySingleton(() => SaveTvWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveTvWatchlist(locator()));
  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => SslPinningHelper.client);
}
