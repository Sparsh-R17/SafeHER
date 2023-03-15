import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyDz6V5mMH6pdHo_tO-DmqmUE1Xq6FIQBwE';

class LocationHelper {
  static String generateLocationImage(
      {required double latitude, required double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=14&size=400x300&maptype=roadmap&markers=color:blue%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }
}
