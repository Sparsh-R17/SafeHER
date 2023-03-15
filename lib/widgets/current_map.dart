import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kavach/helper/location_helper.dart';
import 'package:kavach/utils/app_dimension.dart';
import 'package:location/location.dart';

import '../screens/maps_screen.dart';

class CurrentMap extends StatefulWidget {
  const CurrentMap({super.key});

  @override
  State<CurrentMap> createState() => _CurrentMapState();
}

class _CurrentMapState extends State<CurrentMap> {
  final List<int> _chipIndex = [];
  LocationData? currentLocation;
  String? imgUrl;

  void _generateMap(double lat, double lng) {
    imgUrl = LocationHelper.generateLocationImage(
      latitude: lat,
      longitude: lng,
    );
  }

  Future<void> get _getCurrentLocation async {
    try {
      final locData = await Location().getLocation();
      _generateMap(locData.latitude!, locData.longitude!);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _selectMap() async {
    final locationData = await Location().getLocation();
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => MapScreen(
          initialLocation: locationData,
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    //TODO need to change marker according to the place chosen
    setState(() {
      _generateMap(selectedLocation.latitude, selectedLocation.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(
          height: pageHeight * 0.45,
          width: pageWidth * 0.9,
          child: FutureBuilder(
              future: _getCurrentLocation,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return GestureDetector(
                    onTap: _selectMap,
                    child: Card(
                      child: imgUrl == null
                          ? const Center(
                              child: Text('Error Occurred'),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                imgUrl!,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  );
                }
              }),
        ),
        verticalSpacing(pageHeight * 0.01),
        SizedBox(
          height: pageHeight * 0.1,
          width: pageWidth * 0.9,
          child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: pageWidth * 0.015,
                ),
                child: ActionChip(
                  avatar: const Icon(
                    Icons.car_crash,
                  ),
                  onPressed: () {
                    setState(() {
                      if (_chipIndex.contains(index)) {
                        _chipIndex.remove(index);
                      } else {
                        _chipIndex.add(index);
                      }
                    });
                  },
                  side: _chipIndex.contains(index) ? BorderSide.none : null,
                  backgroundColor: _chipIndex.contains(index)
                      ? Theme.of(context).colorScheme.secondaryContainer
                      : null,
                  label: const Text('Police'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
