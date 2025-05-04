import 'package:civix_app/features/edit_profile/presentation/pages/widgets/edit_profile_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/edit_profile_cubit.dart';
import '../cubit/edit_profile_state.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});
  static const routeName = '/edit_profile';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Edit_profileCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Edit_profile Page')),
        body: const EditProfileScreen(),
        // body: BlocBuilder<Edit_profileCubit, Edit_profileState>(
        //   builder: (context, state) {
        //     if (state is Edit_profileLoading) {
        //       return const Center(child: CircularProgressIndicator());
        //     } else if (state is Edit_profileFailure) {
        //       return Center(child: Text('Error: ${state.error}'));
        //     }
        //     return const Center(child: Text('Edit_profile Page'));
        //   },
        // ),
      ),
    );
  }
}
