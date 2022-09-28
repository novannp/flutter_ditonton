import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/tv/seasons_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/tv/tv.dart';
import '../../provider/tv_detail_notifier.dart';

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv';

  final int id;
  TvDetailPage({required this.id});

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TvDetailNotifier>(context, listen: false)
          .fetchTvDetail(widget.id);
      Provider.of<TvDetailNotifier>(context, listen: false)
          .loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.tvDetailState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.tvDetailState == RequestState.Loaded) {
            final tv = provider.tvDetail;
            return SafeArea(
              child: DetailContent(
                  tv, provider.recommendedTv, provider.isAddedToWatchlist),
            );
          } else {
            return Text(provider.message);
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

  DetailContent(this.tvDetail, this.recommendedTv, this.isAddedWatchlist);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvDetail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
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
                                  await Provider.of<TvDetailNotifier>(context,
                                          listen: false)
                                      .addWatchList(tvDetail);
                                } else {
                                  await Provider.of<TvDetailNotifier>(context,
                                          listen: false)
                                      .removeFromWatchList(tvDetail);
                                }

                                final message = Provider.of<TvDetailNotifier>(
                                        context,
                                        listen: false)
                                    .watchListMessage;

                                if (message ==
                                        TvDetailNotifier
                                            .watchlistAddSuccessMessage ||
                                    message ==
                                        TvDetailNotifier
                                            .watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
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
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              'Category : ' + _showGenres(tvDetail.genres),
                            ),
                            SizedBox(height: 2),
                            tvDetail.episodeRunTime.isNotEmpty
                                ? Text(
                                    'Episode Run Time : ' +
                                        tvDetail.episodeRunTime[0].toString() +
                                        ' minutes',
                                  )
                                : SizedBox(),
                            SizedBox(height: 2),
                            Text('Ratings :'),
                            buildRatingBar(),
                            SizedBox(height: 10),
                            Text(
                                'Country : ${tvDetail.originCountry.map((e) => e)} '),
                            SizedBox(height: 10),
                            Text('Language : ${tvDetail.originalLanguage}'),
                            SizedBox(height: 10),
                            Text('Status : ${tvDetail.status}'),
                            SizedBox(height: 10),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvDetail.overview,
                            ),
                            SizedBox(height: 16),
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
                            SizedBox(height: 20),
                            Text('Created By :'),
                            SizedBox(height: 10),
                            buildCreator(),
                            Text('Seasons'),
                            SizedBox(height: 10),
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
                                                    : SizedBox(
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
                                                  "Episode " +
                                                      tvDetail.seasons[index]
                                                          .episodeCount
                                                          .toString(),
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
                            buildRecommendedTv(),
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
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
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
          itemBuilder: (context, index) => Icon(
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
                    : SizedBox(
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

  Consumer<TvDetailNotifier> buildRecommendedTv() {
    return Consumer<TvDetailNotifier>(
      builder: (context, data, child) {
        if (data.recommendedTvState == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.recommendedTvState == RequestState.Error) {
          return Text(data.message);
        } else if (data.recommendedTvState == RequestState.Loaded) {
          return Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        TvDetailPage.ROUTE_NAME,
                        arguments: recommendedTv[index].id,
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                'https://image.tmdb.org/t/p/w500${recommendedTv[index].posterPath}',
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: recommendedTv.length,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
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
