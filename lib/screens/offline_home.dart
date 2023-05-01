import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../providers/trigger.dart';
import '../utils/app_dimension.dart';
import '../utils/sos_fn.dart';
import 'trigger_screen.dart';

class OfflineHome extends StatelessWidget {
  const OfflineHome({super.key});

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Text(
          'You are currently offline',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        verticalSpacing(pageHeight * 0.05),
        SizedBox(
          width: pageWidth * 0.75,
          height: pageHeight * 0.07,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.share_location,
              size: 30,
            ),
            label: const Text(
              'Location Share',
              style: TextStyle(
                fontSize: 21,
              ),
            ),
            style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(
                Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ),
        verticalSpacing(pageHeight * 0.04),
        SizedBox(
          width: pageWidth * 0.75,
          height: pageHeight * 0.07,
          child: Consumer<Trigger>(builder: (_, value, __) {
            return OutlinedButton.icon(
              onPressed: () {
                sendSOS(false);
                value.alertTrigger();
                print("SOS Sent!!");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const TriggerScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.crisis_alert,
                size: 30,
              ),
              label: const Text(
                'SOS',
                style: TextStyle(
                  fontSize: 21,
                ),
              ),
              style: ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(
                  Theme.of(context).colorScheme.error,
                ),
              ),
            );
          }),
        ),
        verticalSpacing(pageHeight * 0.06),
        SizedBox(
          height: pageHeight * 0.3,
          width: pageWidth * 0.7,
          child: SvgPicture.asset(
            'assets/svg/signal.svg',
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}
