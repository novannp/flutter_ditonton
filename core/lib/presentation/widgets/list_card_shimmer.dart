import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListCardSimmer extends StatelessWidget {
  const ListCardSimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
          itemCount: 10,
          itemBuilder: (_, __) {
            return SizedBox(
              child: Shimmer.fromColors(
                direction: ShimmerDirection.ltr,
                baseColor: Colors.grey,
                highlightColor: Colors.white,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(
                    left: 8,
                    bottom: 8,
                    right: 8,
                  ),
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
