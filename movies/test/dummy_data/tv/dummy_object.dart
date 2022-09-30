import 'package:core/domain/entities/genre.dart';
import 'package:tv_series/data/models/tv/tv_table.dart';
import 'package:tv_series/domain/entities/tv/created_by.dart';
import 'package:tv_series/domain/entities/tv/production_country.dart';
import 'package:tv_series/domain/entities/tv/season.dart';
import 'package:tv_series/domain/entities/tv/spoken_language.dart';
import 'package:tv_series/domain/entities/tv/te_episode_to_air.dart';
import 'package:tv_series/domain/entities/tv/tv.dart';
import 'package:tv_series/domain/entities/tv/tv_detail.dart';

final testTv = Tv(
    backdropPath: "backdropPath",
    firstAirDate: DateTime.parse('2022-11-12'),
    genreIds: const [1, 2],
    id: 1,
    name: 'name',
    originCountry: const ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1);

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
    episodeRunTime: const [1, 2, 3],
    firstAirDate: DateTime.parse('2021-01-01'),
    genres: [Genre(id: 1, name: 'name')],
    homepage: 'homepae',
    id: 1,
    inProduction: true,
    languages: const ['en'],
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
    originCountry: const ['en'],
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

final testTvWatchlist = Tv.watchList(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvTable = const TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
