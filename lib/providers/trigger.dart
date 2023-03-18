import 'package:flutter/material.dart';

class Trigger with ChangeNotifier {
  bool pageTrigger = false;
  bool bannerTrigger = false;

  void alertTrigger() {
    // bool cancelMsg = false;
    pageTrigger = !pageTrigger;
    bannerTrigger = !bannerTrigger;
    // if (pageTrigger) {
    //   await showDialog(
    //     barrierDismissible: false,
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         title: const Text('HI'),
    //         actions: [
    //           TextButton(
    //             onPressed: () {
    //               pageTrigger = !pageTrigger;
    //               cancelMsg = true;
    //               Navigator.pop(context);
    //             },
    //             child: const Text('REVERT'),
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // } else {
    //   cancelMsg = false;
    // }
    print(bannerTrigger);
    notifyListeners();
  }

  void timedOutAlert() {
    pageTrigger = !pageTrigger;
    bannerTrigger = true;
    notifyListeners();
  }

  void closeBanner() {
    bannerTrigger = false;
    notifyListeners();
  }
}
