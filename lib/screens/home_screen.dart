import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/internet_connectivity.dart';
import '../providers/trigger.dart';
import '../utils/app_dimension.dart';
import '../utils/sos_fn.dart';
import '../widgets/current_map.dart';
import 'offline_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;
    final connection = Provider.of<InternetConnection>(context);
    final trigger = Provider.of<Trigger>(context);

    if (trigger.bannerTrigger == true) {
      Timer(const Duration(seconds: 20), () {
        print('Timer Finished');
        trigger.closeBanner();
      });
    }
    return SafeArea(
      child: Column(
        children: [
          Stack(
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
                        Theme.of(context).colorScheme.primary.withOpacity(0.08),
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
              trigger.bannerTrigger
                  ? MaterialBanner(
                      content: const Text("Want to cancel SOS ?"),
                      actions: [
                          FilledButton(
                            onPressed: () {
                              trigger.closeBanner();
                              sendSOS(true);
                              print("Banner Cancel!");
                            },
                            child: const Icon(Icons.close),
                            style: ButtonStyle(
                                iconColor: MaterialStatePropertyAll(
                                  Theme.of(context).colorScheme.errorContainer,
                                ),
                                backgroundColor: MaterialStatePropertyAll(
                                  Theme.of(context)
                                      .colorScheme
                                      .onErrorContainer,
                                )),
                          ),
                        ])
                  : Container(
                      color: Colors.transparent,
                    ),
            ],
          ),
          verticalSpacing(pageHeight * 0.05),
          Expanded(
            child: connection.status == ConnectivityMode.offline
                ? const OfflineHome()
                : const CurrentMap(),
          ),
        ],
      ),
    );
  }
}
