import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:civix_app/features/pickmyarea/presentation/views/pick_my_area_view.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickLocationWidget extends StatelessWidget {
  const PickLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        String locationText;

        if (state is HomeSuccess || state is HomeFailure) {
          locationText = BlocProvider.of<HomeCubit>(context).savedArea ??
              S.of(context).pick_location;
        } else if (state is HomeLoading) {
          locationText = 'Loading...';
        } else {
          locationText = S.of(context).pick_location;
        }

        return GestureDetector(
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PickMyAreaView()),
            );

            if (result != null && context.mounted) {
              context.read<HomeCubit>().saveArea(result);
            }
          },
          child: Row(
            children: [
              const Icon(Icons.location_on_outlined, color: Colors.orange),
              const SizedBox(width: 4),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.3,
                ),
                child: Text(
                  locationText,
                  style: TextStyles.bold15inter,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        );
      },
    );
  }
}
