import 'package:ditonton/data/datasources/db/database_helper.dart';

import '../../common/exception.dart';
import '../models/tv_table.dart';

abstract class TvLocalDataSource {
  Future<String> insertTvWatchlist(TvTable tv);
  Future<String> removeTvWatchlist(TvTable tv);
  Future<TvTable?> getTvById(int id);
  Future<List<TvTable>> getWatchlistTv();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<TvTable?> getTvById(int id) async {
    final result = await databaseHelper.getTvById(id);
    if (result != null) {
      return TvTable.fromMap(result);
    }
    return null;
  }

  @override
  Future<List<TvTable>> getWatchlistTv() async {
    final result = await databaseHelper.getWatchlistTv();
    return result.map((e) => TvTable.fromMap(e)).toList();
  }

  @override
  Future<String> insertTvWatchlist(TvTable tv) async {
    try {
      await databaseHelper.insertTvWatchList(tv);
      return "added to watchlist";
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeTvWatchlist(TvTable tv) async {
    try {
      await databaseHelper.removeTvWatchlist(tv);
      return 'Removed ';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
