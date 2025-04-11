import 'package:civix_app/core/services/get_it_service.dart';
import 'package:civix_app/features/my_reports/domain/repos/my_reports_repo.dart';
import 'package:civix_app/features/my_reports/presentation/cubit/my_reports_cubit.dart';
import 'package:civix_app/features/my_reports/presentation/views/widgets/my_reports_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyReportsView extends StatelessWidget {
  const MyReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      //  appBar: AppBar(title: const Text('My Reports')),
      body: MyReportsViewBody(),
    );
  }
}
