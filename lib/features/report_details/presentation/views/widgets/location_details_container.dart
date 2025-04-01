import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_images.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/features/report_details/presentation/views/widgets/issue_location_map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IssueLocationContainer extends StatelessWidget {
  const IssueLocationContainer({
    super.key,
    required this.location,
  });
  final LatLng location;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () async {
          Navigator.of(context)
              .pushNamed(IssueMapLocation.routeName, arguments: location);
        },
        child: SizedBox(
          height: 150,
          width: double.infinity,
          child: Ink(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: Ink.image(
                    image: const AssetImage(Assets.imagesMap),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).cardTheme.color,
                    border: Theme.of(context).brightness == Brightness.light
                        ? Border.all(width: 2)
                        : null,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(width: 8),
                      Text("See Location", style: TextStyles.bold15inter),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
