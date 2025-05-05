import 'package:civix_app/features/pickmyarea/presentation/cubits/pick_my_area_cubit/pick_my_area_cubit.dart';
import 'package:civix_app/features/pickmyarea/presentation/views/widgets/city_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../../generated/l10n.dart';

class PickMyAreaViewBody extends StatefulWidget {
  const PickMyAreaViewBody({super.key, required this.areas});
  final List<String> areas;
  @override
  _PickMyAreaViewBodyState createState() => _PickMyAreaViewBodyState();
}

class _PickMyAreaViewBodyState extends State<PickMyAreaViewBody> {
  List<String> filteredAreas = [];
  String? selectedArea;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredAreas = widget.areas;
    if (widget.areas.length == 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context, widget.areas.first);
      });
    }
  }

  void onSearchChanged(String query) {
    setState(() {
      searchQuery = query;
      filteredAreas = widget.areas
          .where((c) => c.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Widget buildCityList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: filteredAreas.length,
      itemBuilder: (context, index) {
        final area = filteredAreas[index];
        return ListTile(
          title: Text(area),
          onTap: () async {
            setState(() {
              selectedArea = area;
            });
            Navigator.pop(context, selectedArea);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchField(onChanged: onSearchChanged),
          const SizedBox(height: 10),
          const UseCurrentLocationWidget(),
          const SizedBox(height: 10),
          Expanded(child: buildCityList())
        ],
      ),
    );
  }
}

class UseCurrentLocationWidget extends StatelessWidget {
  const UseCurrentLocationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
      ),
      onPressed: () async {
        await BlocProvider.of<PickMyAreaCubit>(context).fetchAreasByLatLong();
      },
      icon: const Icon(
        Icons.my_location,
        color: Colors.orange,
      ),
      label: Align(
        alignment: Directionality.of(context) == TextDirection.rtl
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Text(
          S.of(context).use_current_location,
          style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
        ),
      ),
    );
  }
}
