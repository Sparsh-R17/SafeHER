import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:location/location.dart';

const GOOGLE_API_KEY = 'YOUR_API_KEY';

class LocationHelper {
  static String generateLocationImage(
      {required double latitude,
      required double longitude,
      required String safePlaceUrl}) {
    print(
        'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=15&size=400x300&maptype=roadmap&markers=color:red%7C%7C$latitude,$longitude$safePlaceUrl&key=$GOOGLE_API_KEY');
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=15&size=400x300&maptype=roadmap&markers=color:red%7C%7C$latitude,$longitude$safePlaceUrl&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaces(
      LocationData location, String placeType) async {
    print(location);
    print(placeType);
    List<double> lat = [];
    List<double> lng = [];
    String markers = '';
    var label = 65;
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${location.latitude},${location.longitude}&radius=1500&type=$placeType&key=$GOOGLE_API_KEY');

    final response = await http.get(url);
    final extractedData = json.decode(response.body);

    for (var i = 0; i < extractedData.length; i++) {
      lat.add(extractedData['results'][i]['geometry']['location']['lat']);
      lng.add(extractedData['results'][i]['geometry']['location']['lng']);
      markers +=
          '&markers=color:green%7Clabel:${String.fromCharCode(label + i)}%7C${lat[i]},${lng[i]}';
    }

    print('lat : $lat');
    print('lng : $lng');
    // print(markers);

    return markers;
  }
}
