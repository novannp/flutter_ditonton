import 'package:ditonton/data/models/movie/movie_table.dart';
import 'package:ditonton/data/models/tv/tv_table.dart';
import 'package:ditonton/domain/entities/tv/created_by.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/entities/movie/movie_detail.dart';
import 'package:ditonton/domain/entities/tv/production_country.dart';
import 'package:ditonton/domain/entities/tv/season.dart';
import 'package:ditonton/domain/entities/tv/spoken_language.dart';
import 'package:ditonton/domain/entities/tv/te_episode_to_air.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testTv = Tv(
    backdropPath: "backdropPath",
    firstAirDate: DateTime.parse('2022-11-12'),
    genreIds: [1, 2],
    id: 1,
    name: 'name',
    originCountry: ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1);

final testMovieList = [testMovie];

final testTvList = [testTv];

final testTvDetail = TvDetail(
    adult: false,
    backdropPath: '',
    createdBy: [
      CreatedBy(
          id: 1,
          creditId: '1',
          name: 'name',
          gender: 2,
          profilePath: 'profilePath')
    ],
    episodeRunTime: [1, 2, 3],
    firstAirDate: DateTime.parse('2021-01-01'),
    genres: [Genre(id: 1, name: 'name')],
    homepage: 'homepae',
    id: 1,
    inProduction: true,
    languages: ['en'],
    lastAirDate: DateTime.parse('2022-11-22'),
    lastEpisodeToAir: TEpisodeToAir(
        airDate: DateTime.parse('2022-11-22'),
        episodeNumber: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        productionCode: 'productionCode',
        seasonNumber: 1,
        stillPath: 'stillPath',
        voteAverage: 1,
        voteCount: 1,
        runtime: 20,
        showId: 1),
    name: 'name',
    nextEpisodeToAir: TEpisodeToAir(
        airDate: DateTime.parse('2022-11-22'),
        episodeNumber: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        productionCode: 'productionCode',
        seasonNumber: 1,
        stillPath: 'stillPath',
        voteAverage: 1,
        voteCount: 1,
        runtime: 20,
        showId: 1),
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originCountry: ['en'],
    originalLanguage: 'en',
    originalName: 'name',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    seasons: [
      Season(
          airDate: DateTime.parse('2022-11-22'),
          episodeCount: 1,
          id: 1,
          name: 'name',
          overview: 'overview',
          posterPath: 'posterPath',
          seasonNumber: 1)
    ],
    spokenLanguages: [
      SpokenLanguage(
          englishName: 'englishName', iso6391: 'iso6391', name: 'name')
    ],
    status: 'status',
    tagline: 'tagline',
    type: 'type',
    voteAverage: 1,
    voteCount: 1,
    productionCountries: [
      ProductionCountry(iso31661: 'iso31661', name: 'name')
    ]);

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testTvWatchlist = Tv.watchList(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};
final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
