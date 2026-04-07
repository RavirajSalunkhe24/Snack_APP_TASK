import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class SnackShimmer extends StatelessWidget {
  const SnackShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (_, __) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Card(),
        );
      },
    );
  }
}
