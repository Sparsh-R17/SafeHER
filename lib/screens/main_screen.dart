import 'package:background_sms/background_sms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kavach/screens/call_screen.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../providers/trigger.dart';
import '../utils/app_dimension.dart';
import '../widgets/current_map.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;
  List<String> trySOS = [
    '09747016882',
    '08178600672',
    '07842318091',
    '09854043770',
    '06203582590',
    '07054571877',
  ];

  void _sendSOS(bool isCancel) async {
    bool isPermission = await Permission.sms.isGranted;
    if (isPermission == false) {
      Permission.sms.request();
    }
    if (isPermission == true) {
      final locData = await Location().getLocation();
      for (var i = 0; i < trySOS.length; i++) {
        final result = await BackgroundSms.sendMessage(
          phoneNumber: trySOS[i],
          message: isCancel
              ? 'Sorry Galti se aaya '
              : "Trial SOS.\nLocation : ${locData.latitude}, ${locData.longitude}",
        );
        if (result == SmsStatus.sent) {
          print("Sent");
        } else {
          print("Failed");
        }
      }
    }
  }

  void _showOverlay() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('Hello'),
          title: Text('SWIFT'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.close),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: pageIndex == 1
          ? const CallScreen()
          : SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: pageHeight * 0.015,
                          left: pageWidth * 0.03,
                        ),
                        child: CircleAvatar(
                          minRadius: pageWidth * 0.08,
                          maxRadius: pageWidth * 0.11,
                          backgroundColor: Color.alphaBlend(
                            Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.08),
                            Theme.of(context).colorScheme.surface,
                          ),
                          child: CircleAvatar(
                            minRadius: pageWidth * 0.06,
                            maxRadius: pageWidth * 0.09,
                            foregroundImage:
                                const AssetImage('assets/png/avatar_1.png'),
                          ),
                        ),
                      ),
                      horizontalSpacing(pageWidth * 0.03),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpacing(pageHeight * 0.015),
                          Text(
                            'Hello',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Ayushri Bhuyan',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  verticalSpacing(pageHeight * 0.05),
                  const Expanded(
                    child: CurrentMap(),
                  ),
                ],
              ),
            ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(
          bottom: pageHeight * 0.01,
        ),
        width: pageWidth * 0.35,
        height: pageHeight * 0.08,
        child: Consumer<Trigger>(builder: (_, obj, __) {
          return FloatingActionButton.extended(
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
            onPressed: () async {
              _sendSOS(false);
              final cancel = await obj.alertTrigger(context);
              if (cancel == true) {
                _sendSOS(true);
              }
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          if (index == 2) {
            showModalBottomSheet(
              isDismissible: false,
              context: context,
              builder: (context) {
                return SizedBox(
                  height: pageHeight * 0.4,
                  width: pageWidth,
                  child: Card(
                    child: GestureDetector(
                      child: Center(
                        child: Text('Hello'),
                      ),
                      onTap: () {
                        setState(() {
                          pageIndex = 0;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
            );
          }
          setState(() {
            pageIndex = index;
          });
        },
        selectedIndex: pageIndex,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(
              Icons.home_outlined,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.phone_callback),
            icon: Icon(
              Icons.phone_callback_outlined,
            ),
            label: 'Fake Call',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.share_location),
            icon: Icon(
              Icons.share_location_outlined,
            ),
            label: 'Location',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.support_agent),
            icon: Icon(
              Icons.support_agent_outlined,
            ),
            label: 'Help Desk',
          ),
        ],
      ),
    );
  }
}
