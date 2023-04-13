import 'package:firebase_database/firebase_database.dart';

final firebaseRef = FirebaseDatabase(
        databaseURL:
            'https://kavach-be141-default-rtdb.asia-southeast1.firebasedatabase.app')
    .ref()
    .child('triggers');

callTriggerForUser(value) {
  firebaseRef.update(
    {'userId': value},
  );
}
