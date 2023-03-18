import 'package:background_sms/background_sms.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';


List<String> trySOS = [
    '09747016882',
    '08178600672',
    '07842318091',
    '09854043770',
    '06203582590',
    '07054571877',
  ];

void sendSOS(bool isCancel) async {
    bool isPermission = await Permission.sms.isGranted;
    if (isPermission == false) {
      Permission.sms.request();
    }
    if (isPermission == true) {
      final locData = await Location().getLocation();
      String cancelMsg = 'Sorry Galti se aaya ';
      String sosMsg =
          "Trial SOS.\nLocation : ${locData.latitude}, ${locData.longitude}";
      for (var i = 0; i < trySOS.length; i++) {
        final result = await BackgroundSms.sendMessage(
          phoneNumber: trySOS[i],
          message: isCancel ? cancelMsg : sosMsg,
        );
        if (result == SmsStatus.sent) {
          print("Sent");
        } else {
          print("Failed");
        }
      }
    }
  }
