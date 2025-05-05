import 'package:civix_app/features/pickmyarea/presentation/views/widgets/city_search_field.dart';
import 'package:flutter/material.dart';
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
  }

  void onSearchChanged(String query) {
    setState(() {
      searchQuery = query;
      filteredAreas = widget.areas
          .where((c) => c.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> useCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // Handle permission denied
      return;
    }
    final position = await Geolocator.getCurrentPosition();
    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (placemarks.isNotEmpty) {
      final place = placemarks.first;
      final cleaned = cleanGovernorate(place.administrativeArea ?? '');
      setState(() {
        selectedArea = cleaned;
      });
      if (mounted) {
        Navigator.pop(context, selectedArea);
      }
    }
  }

  String cleanGovernorate(String administrativeArea) {
    return administrativeArea
        .replaceAll(' Governorate', '')
        .replaceAll('Governorate ', '')
        .trim();
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
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
            ),
            onPressed: useCurrentLocation,
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
          ),
          const SizedBox(height: 10),
          Expanded(child: buildCityList())
        ],
      ),
    );
  }
}
