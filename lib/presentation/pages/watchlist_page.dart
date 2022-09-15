import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/tv_card_list.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistMovieNotifier>(context, listen: false)
            .fetchWatchlistMovies());
    Future.microtask(() =>
        Provider.of<WatchListTvNotifier>(context, listen: false)
            .fetchWatchlistTv());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    Provider.of<WatchListTvNotifier>(context, listen: false).fetchWatchlistTv();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Watchlist'),
          bottom: TabBar(
            indicatorColor: Colors.amber,
            tabs: [
              Tab(
                text: 'Movies',
                icon: Icon(Icons.movie_creation_outlined),
              ),
              Tab(
                text: 'TV Series',
                icon: Icon(Icons.tv_outlined),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildMoviesWatchlist(),
            buildTvWatchlist(),
          ],
        ),
      ),
    );
  }

  Padding buildMoviesWatchlist() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<WatchlistMovieNotifier>(
        builder: (context, movie, child) {
          if (movie.watchlistState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (movie.watchlistState == RequestState.Loaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movieData = movie.watchlistMovies[index];
                return MovieCard(movieData);
              },
              itemCount: movie.watchlistMovies.length,
            );
          } else {
            return Center(
              key: Key('error_message'),
              child: Text(movie.message),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}

Widget buildTvWatchlist() {
  return Padding(
    padding: const EdgeInsets.all(8),
    child:
        Consumer<WatchListTvNotifier>(builder: (context, tvWatchlist, child) {
      if (tvWatchlist.watchlistState == RequestState.Loading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (tvWatchlist.watchlistState == RequestState.Loaded) {
        final result = tvWatchlist.watchlistTv;
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            final tv = result[index];
            return TvCard(tv);
          },
          itemCount: result.length,
        );
      } else {
        return Expanded(
          child: Container(),
        );
      }
    }),
  );
}
