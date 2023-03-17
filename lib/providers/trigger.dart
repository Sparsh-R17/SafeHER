import 'package:flutter/material.dart';

class Trigger with ChangeNotifier {
  bool pageTrigger = false;

  

  Future<bool> alertTrigger(BuildContext context) async {
    bool cancelMsg = false;
    pageTrigger = !pageTrigger;

    if (pageTrigger) {
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('HI'),
            actions: [
              TextButton(
                onPressed: () {
                  pageTrigger = !pageTrigger;
                  cancelMsg = true;
                  Navigator.pop(context);
                },
                child: const Text('REVERT'),
              ),
            ],
          );
        },
      );
    } else {
      cancelMsg = false;
    }
    notifyListeners();
    return cancelMsg;
  }
}
