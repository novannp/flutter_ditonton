import 'package:core/presentation/widgets/list_card_shimmer.dart';
import 'package:tv_series/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/bloc/movie/movies_bloc.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';
import 'package:tv_series/presentation/bloc/tv/tv_bloc.dart';

import '../../utils/utils.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<WatchlistTvBloc>().add(FetchWatchListTv());
      context.read<WatchListBloc>().add(FetchWatchlistMovies());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchListBloc>().add(FetchWatchlistMovies());
    context.read<WatchlistTvBloc>().add(FetchWatchListTv());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Watchlist'),
          bottom: const TabBar(
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
      child: BlocBuilder<WatchListBloc, MovieBlocState>(
        builder: (context, state) {
          if (state is MoviesLoading) {
            return const Center(
              child: ListCardSimmer(),
            );
          } else if (state is WatchlistMovieHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movieData = state.movies[index];
                return MovieCard(movieData);
              },
              itemCount: state.movies.length,
            );
          } else if (state is MoviesHasError) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return Text('Watchlist Empty');
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
    child: BlocBuilder<WatchlistTvBloc, TvState>(
      builder: (context, state) {
        if (state is TvLoading) {
          return const Center(
            child: ListCardSimmer(),
          );
        } else if (state is WatchlistTvHasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final tvData = state.tvs[index];
              return TvCard(tvData);
            },
            itemCount: state.tvs.length,
          );
        } else if (state is TvHasError) {
          return Center(
            key: const Key('error_message'),
            child: Text(state.message),
          );
        } else {
          return Text('Watchlist Empty');
        }
      },
    ),
  );
}
