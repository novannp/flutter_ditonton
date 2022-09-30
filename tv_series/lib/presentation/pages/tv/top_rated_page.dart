import 'package:core/presentation/widgets/list_card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/tv/tv_bloc.dart';
import '../../widgets/tv_card_list.dart';

class TopRatedTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';

  @override
  _TopRatedTvPageState createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<TopRatedTvBloc>().add(FetchTopRatedTv()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvBloc, TvState>(builder: (context, state) {
          if (state is TvLoading) {
            return const ListCardSimmer();
          } else if (state is TvHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tv = state.tvs[index];
                return TvCard(tv);
              },
              itemCount: state.tvs.length,
            );
          } else if (state is TvHasError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Text('Data is Empty');
          }
        }),
      ),
    );
  }
}
