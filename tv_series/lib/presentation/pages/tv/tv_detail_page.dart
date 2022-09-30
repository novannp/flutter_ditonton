import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/presentation/widgets/simmer_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv_series/presentation/pages/tv/seasons_detail_page.dart';

import '../../../domain/entities/tv/tv.dart';
import '../../../domain/entities/tv/tv_detail.dart';
import '../../bloc/tv/tv_bloc.dart';

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv';

  final int id;
  const TvDetailPage({required this.id});

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvDetailBloc>().add(FetchTvDetail(widget.id));
      context
          .read<RecommendationTvBloc>()
          .add(FetchTvRecommendation(widget.id));
      context.read<WatchlistTvBloc>().add(LoadWatchlistTvStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final recommendedTv =
        context.select<RecommendationTvBloc, List<Tv>>((value) {
      if (value.state is TvHasData) {
        return (value.state as TvHasData).tvs;
      } else {
        return [];
      }
    });

    var isAddedToWatchlist = context.select<WatchlistTvBloc, bool>((value) {
      var state = value.state;
      if (state is LoadWatchlistTvData) {
        return state.status;
      }
      return false;
    });

    return Scaffold(
      body: BlocBuilder<TvDetailBloc, TvState>(
        builder: (context, state) {
          if (state is TvLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvDetailHasData) {
            final tv = state.tv;
            return SafeArea(
              child: DetailContent(tv, recommendedTv, isAddedToWatchlist),
            );
          } else if (state is TvHasError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text('Can\'t load data'),
            );
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvDetail tvDetail;
  final List<Tv> recommendedTv;
  final bool isAddedWatchlist;

  const DetailContent(this.tvDetail, this.recommendedTv, this.isAddedWatchlist);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvDetail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvDetail.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  context
                                      .read<WatchlistTvBloc>()
                                      .add(SaveWatchlistTv(tvDetail));
                                } else {
                                  context
                                      .read<WatchlistTvBloc>()
                                      .add(RemoveWatchlistTv(tvDetail));
                                }

                                String message = '';

                                final state =
                                    BlocProvider.of<WatchlistTvBloc>(context)
                                        .state;
                                if (state is LoadWatchlistTvData) {
                                  message = isAddedWatchlist
                                      ? WatchlistTvBloc
                                          .watchlistRemoveSuccessMessage
                                      : WatchlistTvBloc
                                          .watchlistAddSuccessMessage;
                                } else {
                                  message = isAddedWatchlist == false
                                      ? WatchlistTvBloc
                                          .watchlistAddSuccessMessage
                                      : WatchlistTvBloc
                                          .watchlistRemoveSuccessMessage;
                                }

                                if (message ==
                                        WatchlistTvBloc
                                            .watchlistAddSuccessMessage ||
                                    message ==
                                        WatchlistTvBloc
                                            .watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                  // Load new status
                                  BlocProvider.of<WatchlistTvBloc>(context)
                                      .add(LoadWatchlistTvStatus(tvDetail.id));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              'Category : ${_showGenres(tvDetail.genres)}',
                            ),
                            const SizedBox(height: 2),
                            tvDetail.episodeRunTime.isNotEmpty
                                ? Text(
                                    'Episode Run Time : ${tvDetail.episodeRunTime[0]} minutes',
                                  )
                                : const SizedBox(),
                            const SizedBox(height: 2),
                            const Text('Ratings :'),
                            buildRatingBar(),
                            const SizedBox(height: 10),
                            Text(
                                'Country : ${tvDetail.originCountry.map((e) => e)} '),
                            const SizedBox(height: 10),
                            Text('Language : ${tvDetail.originalLanguage}'),
                            const SizedBox(height: 10),
                            Text('Status : ${tvDetail.status}'),
                            const SizedBox(height: 10),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvDetail.overview,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Chip(
                                  label: Text(
                                      'Season : ${tvDetail.numberOfSeasons}'),
                                ),
                                const SizedBox(width: 10),
                                Chip(
                                    label: Text(
                                        'Episode : ${tvDetail.numberOfEpisodes}')),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Text('Created By :'),
                            const SizedBox(height: 10),
                            buildCreator(),
                            const Text('Seasons'),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 120,
                              child: tvDetail.seasons.isNotEmpty
                                  ? ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: tvDetail.seasons.length,
                                      itemBuilder: (context, int index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SeasonsDetailPage(
                                                            season: tvDetail
                                                                    .seasons[
                                                                index])));
                                          },
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(right: 8),
                                            child: Column(
                                              children: [
                                                tvDetail.seasons[index]
                                                            .posterPath !=
                                                        null
                                                    ? CircleAvatar(
                                                        radius: 30,
                                                        foregroundColor:
                                                            Colors.amber,
                                                        backgroundImage:
                                                            CachedNetworkImageProvider(
                                                                'https://image.tmdb.org/t/p/w500${tvDetail.seasons[index].posterPath}'),
                                                      )
                                                    : const SizedBox(
                                                        height: 60,
                                                        width: 60,
                                                        child: Center(
                                                            child: Text(
                                                                'no image')),
                                                      ),
                                                SizedBox(
                                                  width: 80,
                                                  child: Text(
                                                    tvDetail.seasons[index]
                                                            .name ??
                                                        '-',
                                                    maxLines: 1,
                                                    textAlign: TextAlign.center,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Text(
                                                  "Episode ${tvDetail.seasons[index].episodeCount}",
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : Container(),
                            ),
                            Text(
                              'Recommended',
                              style: kHeading6,
                            ),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final movie = recommendedTv[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          TvDetailPage.ROUTE_NAME,
                                          arguments: movie.id,
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: ShimmerCard(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: recommendedTv.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  Row buildRatingBar() {
    return Row(
      children: [
        RatingBarIndicator(
          rating: tvDetail.voteAverage / 2,
          itemCount: 5,
          itemBuilder: (context, index) => const Icon(
            Icons.star,
            color: kMikadoYellow,
          ),
          itemSize: 24,
        ),
        Text('${tvDetail.voteAverage}')
      ],
    );
  }

  SizedBox buildCreator() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tvDetail.createdBy.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: Column(
              children: [
                tvDetail.createdBy[index].profilePath != null
                    ? CircleAvatar(
                        radius: 30,
                        foregroundColor: Colors.amber,
                        backgroundImage: CachedNetworkImageProvider(
                            'https://image.tmdb.org/t/p/w500${tvDetail.createdBy[index].profilePath}'),
                      )
                    : const SizedBox(
                        height: 60,
                        width: 60,
                        child: Center(child: Text('no image')),
                      ),
                Text(
                  tvDetail.createdBy[index].name ?? '-',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
