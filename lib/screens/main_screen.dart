import 'package:flutter/material.dart';
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

  List pages = const [
    HomeScreen(),
    CallScreen(),
    LocationScreen(),
    InfoScreen(),
  ];

  @override
  void initState() {
    super.initState();
    getConnection();
  }

  void getConnection() async {
    Provider.of<InternetConnection>(context, listen: false).checkConnection();
    Provider.of<InternetConnection>(context, listen: false)
        .checkRealTimeConnection();
  }

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;
    final connection = Provider.of<InternetConnection>(context);

    return connection.status != ConnectivityMode.waiting
        ? Scaffold(
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
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
