// To parse this JSON data, do
//
//     final tvDetailResponse = tvDetailResponseFromJson(jsonString);

import 'package:ditonton/domain/entities/production_country.dart';

import 'created_by.dart';
import 'genre.dart';
import 'season.dart';
import 'spoken_language.dart';
import 'te_episode_to_air.dart';

class TvDetail {
  TvDetail({
    required this.adult,
    required this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.lastEpisodeToAir,
    required this.name,
    required this.nextEpisodeToAir,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.seasons,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
    required List<ProductionCountry> productionCountries,
  });

  final bool adult;
  final String backdropPath;
  final List<CreatedBy> createdBy;
  final List<int> episodeRunTime;
  final DateTime firstAirDate;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final bool inProduction;
  final List<String> languages;
  final DateTime lastAirDate;
  final TEpisodeToAir lastEpisodeToAir;
  final String name;
  final TEpisodeToAir? nextEpisodeToAir;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;

  final List<Season> seasons;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;
}
