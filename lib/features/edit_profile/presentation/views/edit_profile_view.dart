import 'package:civix_app/core/services/get_it_service.dart';
import 'package:civix_app/features/edit_profile/domain/repositories/edit_profile_repo.dart';
import 'package:civix_app/features/edit_profile/presentation/views/widgets/edit_profile_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/edit_profile_cubit.dart';
import '../cubit/edit_profile_state.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key, required this.token});
  final String token;
  static const routeName = '/edit_profile';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditProfileCubit(
        getIt.get<EditProfileRepo>(),
      )..getCurrentUser(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Edit Profile')),
        body: BlocBuilder<EditProfileCubit, EditProfileState>(
          builder: (context, state) {
            if (state is EditProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EditProfileFailure) {
              return Center(child: Text(state.error));
            } else if (state is EditProfileSuccess) {
              return EditProfileViewBody(
                user: state.user,
                token: token,
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
