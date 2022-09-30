import 'package:flutter_test/flutter_test.dart';
import 'package:movies/data/models/movie/movie_model.dart';
import 'package:movies/domain/entities/movie/movie.dart';

void main() {
  final tMovieModel = MovieModel(
    backdropPath: 'backdropPath',
    genreIds: [1, 2],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
    adult: false,
    originalTitle: 'e',
    releaseDate: '2022-11-11',
    title: 'title',
    video: false,
  );
  final tMovie = Movie(
    backdropPath: 'backdropPath',
    genreIds: [1, 2],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
    adult: false,
    originalTitle: 'e',
    releaseDate: '2022-11-11',
    title: 'title',
    video: false,
  );

  test('should be a subclass', () {
    final result = tMovieModel.toEntity();
    expect(result, tMovie);
  });
}
