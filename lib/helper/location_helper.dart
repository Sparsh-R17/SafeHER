import 'dart:convert';

import 'package:location/location.dart';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyDz6V5mMH6pdHo_tO-DmqmUE1Xq6FIQBwE';

class LocationHelper {
  static String generateLocationImage(
      {required double latitude, required double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=15&size=400x300&maptype=roadmap&markers=color:blue%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static getPlaces(LocationData location, String placeType) async {
    print(location);
    print(placeType);
    List<double> lat = [];
    List<double> lng = [];
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${location.latitude},${location.longitude}&radius=1500&type=$placeType&key=$GOOGLE_API_KEY');

    final response = await http.get(url);
    final extractedData = json.decode(response.body);

    print(extractedData);

    for (var i = 0; i < extractedData.length; i++) {
      lat.add(extractedData['results'][i]['geometry']['location']['lat']);
      lng.add(extractedData['results'][i]['geometry']['location']['lng']);
    }

    print('lat : $lat');
    print('lng : $lng');
  }
}
