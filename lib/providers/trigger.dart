import 'package:flutter/material.dart';

class Trigger with ChangeNotifier {
  bool pageTrigger = false;


  void alertTrigger() {
    pageTrigger = !pageTrigger;
    notifyListeners();
  }
}
