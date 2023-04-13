import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../helper/location_helper.dart';
import '../utils/app_dimension.dart';
import 'package:location/location.dart';

import '../screens/maps_screen.dart';

class CurrentMap extends StatefulWidget {
  const CurrentMap({super.key});

  @override
  State<CurrentMap> createState() => _CurrentMapState();
}

class _CurrentMapState extends State<CurrentMap> {
  int _chipIndex = -1;
  LocationData? currentLocation;
  String? imgUrl;
  String marker = '';
  void _generateMap(double lat, double lng, String nearPlace) {
    // imgUrl = LocationHelper.generateLocationImage(
        // latitude: lat, longitude: lng, safePlaceUrl: nearPlace);
  }

  List<dynamic> safePlaces = [
    {
      'icon': Icons.local_police,
      'title': 'Police',
    },
    {
      'icon': Icons.local_hospital,
      'title': 'Hospital',
    },
    {
      'icon': Icons.local_mall,
      'title': 'Mall',
    },
    {
      'icon': Icons.school,
      'title': 'School',
    },
  ];

  Future<void> _getCurrentLocation(String nearPlaces) async {
    try {
      final locData = await Location().getLocation();
      currentLocation = locData;
      print(nearPlaces);
      // _generateMap(locData.latitude!, locData.longitude!, nearPlaces);
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
    // setState(() {
    //   _generateMap(selectedLocation.latitude, selectedLocation.longitude);
    // });
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
              future: _getCurrentLocation(marker),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return GestureDetector(
                    // onTap: _selectMap,
                    onTap: null,
                    child: Card(
                      child: imgUrl == null
                          ? const Center(
                              child: Text('Some Error Occurred'),
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
            itemCount: safePlaces.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: pageWidth * 0.018,
                ),
                child: ActionChip(
                  avatar: Icon(safePlaces[index]['icon']),
                  onPressed: () async {
                    if (_chipIndex == index) {
                      setState(() {
                        _chipIndex = -1;
                        marker = '';
                        // _getCurrentLocation('');
                      });
                    } else {
                      marker = await LocationHelper.getPlaces(
                              currentLocation!,
                              (safePlaces[index]['title'])
                                  .toString()
                                  .toLowerCase())
                          .catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'No ${safePlaces[index]['title']} found in 1.5km radius'),
                          ),
                        );
                      });

                      setState(() {
                        print(marker);
                        _chipIndex = index;
                        _getCurrentLocation(marker);
                      });
                    }
                  },
                  side: _chipIndex == index
                      ? const BorderSide(
                          color: Colors.transparent,
                        )
                      : null,
                  backgroundColor: _chipIndex == index
                      ? Theme.of(context).colorScheme.secondaryContainer
                      : null,
                  label: Text(safePlaces[index]['title']),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
