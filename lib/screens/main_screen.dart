import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:provider/provider.dart';

import 'package:shake_event/shake_event.dart';

import '../providers/internet_connectivity.dart';
import '../providers/trigger.dart';
import '../screens/trigger_screen.dart';

import '../utils/db_trigger.dart';
import '../utils/motion_model.dart';
import '../utils/sos_fn.dart';
import '../widgets/location_share.dart';
import 'call_screen.dart';
import 'home_screen.dart';
import 'info_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with ShakeHandler {
  int pageIndex = 0;
  int shakeCount = 0;

  // FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  List pages = const [
    HomeScreen(),
    CallScreen(),
    HomeScreen(),
    InfoScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // motionModel();
    startListeningShake(15);
    getConnection();

    // getNotificationPermission();
    // var initializationSettingsAndroid =
    //     const AndroidInitializationSettings('@mipmap/ic_launcher');

    // var initializationSettings =
    //     InitializationSettings(android: initializationSettingsAndroid);
    // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // flutterLocalNotificationsPlugin!.initialize(initializationSettings);
  }

  timerShake() {
    Timer(const Duration(seconds: 2), () {
      if (shakeCount >= 10) {
        sendSOS(false);
      } else {
        shakeCount = 0;
        print(shakeCount);
      }
    });
  }

 

  @override
  shakeEventListener() {
    // TODO: implement shakeEventListener
    print('shake');
    if (shakeCount == 0) {
      shakeCount += 1;
      timerShake();
    } else {
      shakeCount += 1;
    }
    return super.shakeEventListener();
  }

  // Future _showNotification() async {
  //   var androidPlatformChannel = AndroidNotificationDetails(
  //     'channelId',
  //     'channelName',
  //     channelDescription: 'channelDescription',
  //     playSound: false,
  //     importance: Importance.max,
  //     priority: Priority.high,
  //   );
  //   var platformChannelSpecifics = NotificationDetails(
  //     android: androidPlatformChannel,
  //   );
  //   await flutterLocalNotificationsPlugin!.show(
  //     0,
  //     'New Post',
  //     'Help Needed !!!',
  //     platformChannelSpecifics,
  //   );
  // }

  void getConnection() async {
    Provider.of<InternetConnection>(context, listen: false).checkConnection();
    Provider.of<InternetConnection>(context, listen: false)
        .checkRealTimeConnection();
  }

  // void getNotificationPermission() {
  //   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //       FlutterLocalNotificationsPlugin();
  //   flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()!
  //       .requestPermission();
  // }

  @override
  Widget build(BuildContext context) {
    final connection = Provider.of<InternetConnection>(context);

    return connection.status != ConnectivityMode.waiting
        ? connection.status == ConnectivityMode.offline
            ? mainPageWidget(context)
            : StreamBuilder(
                stream: firebaseRef.onValue,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  var triggerValue = snapshot.data!.snapshot.value as Map;
                  if (triggerValue['userId'] == true) {
                    // _showNotification();
                    callTriggerForUser(false);
                  }
                  return mainPageWidget(context);
                })
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget mainPageWidget(
    BuildContext context,
  ) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;
    final connection = Provider.of<InternetConnection>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: pages[pageIndex],
      floatingActionButton: connection.status == ConnectivityMode.offline
          ? null
          : pageIndex == 0
              ? Container(
                  margin: EdgeInsets.only(
                    bottom: pageHeight * 0.01,
                  ),
                  width: pageWidth * 0.35,
                  height: pageHeight * 0.08,
                  child: Consumer<Trigger>(builder: (_, obj, __) {
                    return FloatingActionButton.extended(
                      backgroundColor:
                          Theme.of(context).colorScheme.errorContainer,
                      onPressed: () {
                        sendSOS(false);
                        obj.alertTrigger();
                        callTriggerForUser(true);
                        // _showNotification();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const TriggerScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.crisis_alert,
                        size: pageHeight * 0.04,
                      ),
                      label: Text(
                        'SOS',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    );
                  }),
                )
              : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          if (index == 2) {
            showModalBottomSheet(
              context: context,
              isDismissible: false,
              enableDrag: false,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              builder: (context) {
                return const LocationShare();
              },
            );
          } else {
            setState(() {
              pageIndex = index;
            });
          }
        },
        selectedIndex: pageIndex,
        destinations: [
          const NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(
              Icons.home_outlined,
            ),
            label: 'Home',
          ),
          if (connection.status != ConnectivityMode.offline)
            const NavigationDestination(
              selectedIcon: Icon(Icons.phone_callback),
              icon: Icon(
                Icons.phone_callback_outlined,
              ),
              label: 'Phone Calls',
            ),
          if (connection.status != ConnectivityMode.offline)
            const NavigationDestination(
              selectedIcon: Icon(Icons.share_location),
              icon: Icon(
                Icons.share_location_outlined,
              ),
              label: 'Location',
            ),
          const NavigationDestination(
            selectedIcon: Icon(Icons.book),
            icon: Icon(
              Icons.book_outlined,
            ),
            label: 'Your Info',
          ),
        ],
      ),
    );
  }
}
