import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/presentation/pages/tv/tv_detail_page.dart';
import 'package:core/presentation/widgets/listview_simmer.dart';
import 'package:core/presentation/widgets/simmer_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/presentation/pages/tv/search_tv_page.dart';

import '../../../domain/entities/tv/tv.dart';
import '../about_page.dart';
import '../watchlist_page.dart';
import 'popular_tv_page.dart';

import 'top_rated_page.dart';

class HomeTvPage extends StatefulWidget {
  @override
  _HomeTvPageState createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<OnTheAirNowBloc>().add(FetchOnTheAirNow());
      context.read<PopularTvBloc>().add(FetchPopularTv());
      context.read<TopRatedTvBloc>().add(FetchTopRatedTv());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: kColorScheme.background,
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: const Text('Ditonton'),
              accountEmail: const Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/home-movie', (route) => false);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('TV Series'),
              key: const Key('tvseries_btn'),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/home-tv', (route) => false);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Ditonton | TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTvPage.ROUTE_NAME);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.live_tv,
                    color: Colors.amber,
                  ),
                  const SizedBox(width: 7),
                  Text(
                    'On The Air Now',
                    style: kHeading6,
                  ),
                ],
              ),
              BlocBuilder<OnTheAirNowBloc, TvState>(builder: (context, state) {
                if (state is TvLoading) {
                  return ListViewSimmer();
                } else if (state is TvHasData) {
                  return TvList(state.tvs);
                } else if (state is TvHasError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Text('Data is empty');
                }
              }),
              _buildSubHeading(
                icon: const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularTvBloc, TvState>(builder: (context, state) {
                if (state is TvLoading) {
                  return ListViewSimmer();
                } else if (state is TvHasData) {
                  return TvList(state.tvs);
                } else if (state is TvHasError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Text('Data is empty');
                }
              }),
              _buildSubHeading(
                icon: const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTvPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedTvBloc, TvState>(builder: (context, state) {
                if (state is TvLoading) {
                  return ListViewSimmer();
                } else if (state is TvHasData) {
                  return TvList(state.tvs);
                } else if (state is TvHasError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Text('Data is empty');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading(
      {required String title, required Icon icon, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            icon,
            Text(
              title,
              style: kHeading6,
            ),
          ],
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tvies;

  const TvList(this.tvies);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: ShimmerCard(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvies.length,
      ),
    );
  }
}
