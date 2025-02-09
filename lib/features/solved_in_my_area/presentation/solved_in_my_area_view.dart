import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/features/home/presentation/views/widgets/newest_reports_header.dart';
import 'package:flutter/material.dart';

class SolvedInMyAreaView extends StatelessWidget {
  const SolvedInMyAreaView({super.key});
  static const routeName = '/solved-in-my-area';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor.withOpacity(0.8),
        title: const Text('Solved In My Area'),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            TextField(
                decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              labelText: 'City',
              border: OutlineInputBorder(),
            )),
            SizedBox(
              height: 16,
            ),
            TextField(
                decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              labelText: 'Region',
              border: OutlineInputBorder(),
            )),
            SizedBox(
              height: 16,
            ),
            NewestReportsHeader(),
          ],
        ),
      ),
    );
  }
}
