import 'package:background_sms/background_sms.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

List<String> trySOS = [
  '08075842864',
  '08178600672',
  '07842318091',
  '09854043770',
  '06203582590',
  '07054571877',
];

void sendSOS(bool isCancel) async {
  // print('sendSOS');
  // bool isPermission = await Permission.sms.isGranted;
  // if (isPermission == false) {
  //   Permission.sms.request();
  // }
  // if (isPermission == true) {
  //   print('sendSOS 2');
  //   final locData = await Location().getLocation();
  //   String cancelMsg = 'Sorry sent by mistake';
  // String sosMsg =
  //     "\nLocation : http://maps.google.com/maps?q=${locData.latitude},${locData.longitude}";
  // for (var i = 0; i < trySOS.length; i++) {
  //   print('sendSOS 3');
  //   final result = await BackgroundSms.sendMessage(
  //     phoneNumber: trySOS[i],
  //     message: isCancel ? cancelMsg : sosMsg,
  //   );
  //   if (result == SmsStatus.sent) {
  //     print("Sent");
  //   } else {
  //     print("Failed");
  //   }
  // }
  // }
}

void shareLocation(List<String> nos, bool stop, String reason) async {
  // bool permissionGranted = await Permission.sms.isGranted;
  // final auth = FirebaseAuth.instance;
  // if (permissionGranted == true) {
  //   final locData = await Location().getLocation();
  //   String startMsg1 =
  //       "You are recieving this msg because you're an emergency contact for ${auth.currentUser!.displayName}.\n${auth.currentUser!.displayName} is sharing their location because ${reason}.";
  //   String startMsg2 =
  //       "Location: :http://maps.google.com/maps?q=${locData.latitude},${locData.longitude} \n\nPlease call or text ${auth.currentUser!.displayName} for updates";
  //   String stopMsg =
  //       "${auth.currentUser!.displayName} stopped sharing location as $reason.";
  //   for (var i = 0; i < nos.length; i++) {
  //     final result1 = await BackgroundSms.sendMessage(
  //       phoneNumber: nos[i],
  //       message: stop ? stopMsg : startMsg1,
  //     );
  //     if (!stop) {
  //       final result2 = await BackgroundSms.sendMessage(
  //         phoneNumber: nos[i],
  //         message: startMsg2,
  //       );
  //     }

  //     if (result1 == SmsStatus.sent) {
  //       print("Sent");
  //     } else {
  //       print("Failed");
  //     }
  //   }
  // }
  print("Location Shared");
}
