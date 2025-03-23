import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerNewestListView extends StatelessWidget {
  const ShimmerNewestListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[500]!.withOpacity(0.5),
      highlightColor: Colors.transparent,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: 4,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 90,
                    child: Row(
                      children: [
                        ShimmerListViewItem(),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Skelton(
                                    width: 40,
                                    height: 20,
                                  ),
                                  Spacer(),
                                  Skelton(
                                    width: 40,
                                    height: 20,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Skelton(
                                width: double.infinity,
                                height: 20,
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Skelton(
                                width: 40,
                                height: 15,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Divider(
                    thickness: 0.15,
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class Skelton extends StatelessWidget {
  const Skelton({
    super.key,
    this.width,
    this.height,
  });
  final double? width, height;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      height: height,
      width: width,
    );
  }
}

class ShimmerListViewItem extends StatelessWidget {
  const ShimmerListViewItem({
    super.key,
    this.padding,
  });
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(right: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AspectRatio(
          aspectRatio: 4 / 3.5,
          child: Container(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
