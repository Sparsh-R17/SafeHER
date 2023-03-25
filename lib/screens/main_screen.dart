import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kavach/main.dart';
import 'package:kavach/screens/call_screen.dart';
import 'package:provider/provider.dart';

import '../providers/internet_connectivity.dart';
import '../providers/trigger.dart';
import '../screens/trigger_screen.dart';
import '../utils/sos_fn.dart';
import 'home_screen.dart';
import 'info_screen.dart';
import 'location_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  final _firebaseRef = FirebaseDatabase(
          databaseURL:
              'https://kavach-be141-default-rtdb.asia-southeast1.firebasedatabase.app')
      .ref()
      .child('triggers');

  List pages = const [
    HomeScreen(),
    CallScreen(),
    LocationScreen(),
    InfoScreen(),
  ];

  callTriggerForUser(value) {
    _firebaseRef.update(
      {'userId': value},
    );
  }

  @override
  void initState() {
    super.initState();
    getConnection();
    getNotificationPermission();
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin!.initialize(initializationSettings);
  }

  Future _showNotification() async {
    var androidPlatformChannel = AndroidNotificationDetails(
      'channelId',
      'channelName',
      channelDescription: 'channelDescription',
      playSound: false,
      importance: Importance.max,
      priority: Priority.high,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannel,
    );
    await flutterLocalNotificationsPlugin!.show(
      0,
      'New Post',
      'Help Needed !!!',
      platformChannelSpecifics,
    );
  }

  void getConnection() async {
    Provider.of<InternetConnection>(context, listen: false).checkConnection();
    Provider.of<InternetConnection>(context, listen: false)
        .checkRealTimeConnection();
  }

  void getNotificationPermission() {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;
    final connection = Provider.of<InternetConnection>(context);

    return connection.status != ConnectivityMode.waiting
        ? StreamBuilder(
            stream: _firebaseRef.onValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var triggerValue = snapshot.data!.snapshot.value as Map;
              if (triggerValue['userId'] == true) {
                _showNotification();
                callTriggerForUser(false);
              }
              return Scaffold(
                resizeToAvoidBottomInset: false,
                body: pages[pageIndex],
                floatingActionButton: connection.status ==
                        ConnectivityMode.offline
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
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .errorContainer,
                                onPressed: () {
                                  callTriggerForUser(true);
                                },
                                // onPressed: () {
                                //   sendSOS(false);
                                //   _showNotification();
                                //   obj.alertTrigger();
                                //   Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (BuildContext context) =>
                                //           const TriggerScreen(),
                                //     ),
                                //   );
                                // },
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
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                bottomNavigationBar: NavigationBar(
                  onDestinationSelected: (int index) {
                    setState(() {
                      pageIndex = index;
                    });
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
            })
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
