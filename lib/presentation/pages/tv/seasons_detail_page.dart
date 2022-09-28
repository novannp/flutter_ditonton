import 'package:ditonton/domain/entities/tv/season.dart';
import 'package:flutter/material.dart';

import '../../../common/constants.dart';

class SeasonsDetailPage extends StatelessWidget {
  final Season season;
  const SeasonsDetailPage({Key? key, required this.season}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seasons'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network('$BASE_IMAGE_URL/${season.posterPath}',
                      height: 200),
                ),
              ),
              Text('Name : ${season.name}', style: kHeading5),
              SizedBox(height: 10),
              Text('Overview', style: kHeading6),
              Text(season.overview == null || season.overview == ''
                  ? 'no overview'
                  : season.overview ?? 'no overview'),
              SizedBox(height: 10),
              Text('Episodes : ${season.episodeCount}', style: kHeading6),
            ],
          ),
        ),
      ),
    );
  }
}
