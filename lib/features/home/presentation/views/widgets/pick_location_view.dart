import 'package:civix_app/features/home/data/models/location_model.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationPickerPage extends StatefulWidget {
  const LocationPickerPage({super.key});

  @override
  _LocationPickerPageState createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  List<City> cities = [];
  List<City> filteredCities = [];
  List<Area> areas = [];
  City? selectedCity;
  String searchQuery = '';
  bool isLoading = false;

  @override
/*************  ✨ Windsurf Command ⭐  *************/
  /// Fetches the list of cities from the server when the widget is first created
  /// *****  9a702450-2109-46e4-9c8b-fe79ebb1f03a  ******
  void initState() {
    super.initState();
    fetchCities();
  }

  @override
  Future<void> fetchCities() async {
    setState(() => isLoading = true);

    // Replace this with actual API call
    await Future.delayed(const Duration(seconds: 1));
    cities = [
      City(id: 1, name: 'Cairo'),
      City(id: 2, name: 'Alexandria'),
      City(id: 3, name: 'Giza'),
    ];

    setState(() {
      filteredCities = cities;
      isLoading = false;
    });
  }

  Future<void> fetchAreas(int cityId) async {
    setState(() => isLoading = true);

    // Replace this with actual API call
    await Future.delayed(const Duration(seconds: 1));
    areas = cityId == 1
        ? [Area(id: 1, name: 'Nasr City'), Area(id: 2, name: 'Maadi')]
        : cityId == 2
            ? [Area(id: 3, name: 'Smouha'), Area(id: 4, name: 'Stanley')]
            : [];

    setState(() {
      isLoading = false;
    });
  }

  void onSearchChanged(String query) {
    setState(() {
      searchQuery = query;
      filteredCities = cities
          .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
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
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    final cityName = placemarks.first.locality?.toLowerCase() ?? 'cairo';

// Normalize the city name by trimming the "Governorate" suffix (if present)
    final normalizedCityName = cityName
        .replaceAll(RegExp(r'(\s*Governorate|\s*City|\s*District)$'), '')
        .trim();

    final matchedCity = cities.firstWhere(
      (c) => c.name.toLowerCase() == normalizedCityName.toLowerCase(),
      orElse: () => City(id: -1, name: 'Cairo'),
    );

    Navigator.pop(context, {'city': matchedCity.name, 'area': null});
  }

  Widget buildCityList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: filteredCities.length,
      itemBuilder: (context, index) {
        final city = filteredCities[index];
        return ListTile(
          title: Text(city.name),
          onTap: () async {
            setState(() {
              selectedCity = city;
              areas = [];
            });
            await fetchAreas(city.id);
          },
        );
      },
    );
  }

  Widget buildAreaList() {
    return Column(
      children: [
        ListTile(
          title: const Text('← Back to cities'),
          onTap: () {
            setState(() {
              selectedCity = null;
              searchQuery = '';
              filteredCities = cities;
            });
          },
        ),
        ...areas.map((area) {
          return ListTile(
            title: Text(area.name),
            onTap: () {
              Navigator.pop(
                  context, {'city': selectedCity!.name, 'area': area.name});
            },
          );
        })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
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
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Use Current Location",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: selectedCity == null
                        ? buildCityList()
                        : buildAreaList(),
                  )
                ],
              ),
            ),
    );
  }
}

class SearchField extends StatefulWidget {
  const SearchField({super.key, required this.onChanged});
  final void Function(String) onChanged;
  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final FocusNode _searchFocus = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _searchFocus.addListener(() {
      setState(() {}); // Rebuild when focus changes
    });
  }

  @override
  void dispose() {
    _searchFocus.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            focusNode: _searchFocus,
            onChanged: widget.onChanged,
            decoration: const InputDecoration(
              hintText: 'Search city or area',
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
          ),
        ),
        if (_searchFocus.hasFocus || _searchController.text.isNotEmpty)
          TextButton(
            onPressed: () {
              _searchController.clear();
              _searchFocus.unfocus();
              widget.onChanged('');
            },
            child: const Text('Cancel'),
          ),
      ],
    );
  }
}
