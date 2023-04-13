import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

enum ConnectivityMode {
  waiting,
  wifi,
  mobile,
  offline,
}

class InternetConnection extends ChangeNotifier {
  ConnectivityMode status = ConnectivityMode.waiting;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _streamSubscription;

  Future<void> checkConnection() async {
    var connectionResult = await _connectivity.checkConnectivity();
    if (connectionResult == ConnectivityResult.mobile) {
      status = ConnectivityMode.mobile;
      notifyListeners();
    } else if (connectionResult == ConnectivityResult.wifi) {
      status = ConnectivityMode.wifi;
      notifyListeners();
    } else {
      status = ConnectivityMode.offline;
      notifyListeners();
    }
  }

  void checkRealTimeConnection() {
    _streamSubscription = _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile) {
        status = ConnectivityMode.mobile;
        notifyListeners();
      } else if (event == ConnectivityResult.wifi) {
        status = ConnectivityMode.wifi;
        notifyListeners();
      } else {
        status = ConnectivityMode.offline;
        notifyListeners();
      }
    });
  }
}
