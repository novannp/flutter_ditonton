import 'package:core/utils/failure.dart';
import 'package:movies/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

import '../../entities/movie/movie.dart';

class GetMovieRecommendations {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
