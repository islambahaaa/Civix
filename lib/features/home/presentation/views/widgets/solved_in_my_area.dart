import 'dart:ui';

import 'package:civix_app/core/utils/app_images.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg;

class SolvedInMyAreaWidget extends StatelessWidget {
  const SolvedInMyAreaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var itemWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      //height: MediaQuery.of(context).size.width * 158 / 342,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: SizedBox(
          width: itemWidth,
          child: AspectRatio(
            aspectRatio: 342 / 158,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  bottom: 0,
                  right: 0,
                  top: 0,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                    child: Image.asset(
                      Assets.imagesCairo,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: Container(
                    width: itemWidth * 0.5,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image:
                                svg.Svg(Assets.imagesSolvedInMyAreaItemShape),
                            fit: BoxFit.fill)),
                    child: Padding(
                        padding: const EdgeInsets.only(
                            right: 25, top: 25, bottom: 25, left: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Solved\nIn My Area',
                              style: TextStyles.semibold24inter
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
