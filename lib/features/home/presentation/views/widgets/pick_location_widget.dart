import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:civix_app/features/pickmyarea/presentation/views/pick_my_area_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickLocationWidget extends StatefulWidget {
  const PickLocationWidget({
    super.key,
  });

  @override
  State<PickLocationWidget> createState() => _PickLocationWidgetState();
}

class _PickLocationWidgetState extends State<PickLocationWidget> {
  String location = 'New York';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PickMyAreaView()),
        );

        if (result != null) {
          setState(() {
            location = result;
          });
          if (context.mounted) {
            BlocProvider.of<HomeCubit>(context).fetchNearMe(area: location);
          }
        }
      },
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined, color: Colors.orange),
          const SizedBox(
            width: 4,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.3,
            ),
            child: Text(
              location,
              style: TextStyles.bold15inter,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const Icon(
            Icons.arrow_drop_down,
          ),
        ],
      ),
    );
  }
}
