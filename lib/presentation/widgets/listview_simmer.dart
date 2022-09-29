import 'package:ditonton/presentation/widgets/simmer_card.dart';
import 'package:flutter/cupertino.dart';

class ListViewSimmer extends StatelessWidget {
  const ListViewSimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (_, __) {
            return ShimmerCard();
          }),
    );
  }
}
