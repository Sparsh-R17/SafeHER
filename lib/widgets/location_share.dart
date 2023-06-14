import 'package:flutter/material.dart';
import 'package:kavach/widgets/location_contacts.dart';

import '../utils/app_dimension.dart';
import 'option_selector.dart';

class LocationShare extends StatefulWidget {
  const LocationShare({super.key});

  @override
  State<LocationShare> createState() => _LocationShareState();
}

String reason = "";
Duration duration = const Duration(minutes: 0);

class _LocationShareState extends State<LocationShare> {
  void _setValues(
    String selectedReason,
    Duration selectedDuration,
  ) {
    setState(() {
      reason = selectedReason;
      duration = selectedDuration;
    });
  }

  String displayDuration(Duration duration) {
    String result = "Duration";
    if (duration == const Duration(minutes: 15)) {
      result = "15 Minutes";
    } else if (duration == const Duration(minutes: 30)) {
      result = "30 Minutes";
    } else if (duration == const Duration(days: 1)) {
      result = "Manually End";
    } else {
      result =
          "${duration.inHours} Hours and ${duration.inMinutes.remainder(60)} minutes";
      if (duration.inMinutes.remainder(60) == 0) {
        result = "${duration.inHours} Hours";
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;

    String infoLocation =
        'When you start a location sharing, your real-time location stays private to you until emergency sharing starts.';
    return Container(
      height: pageHeight * 0.55,
      decoration: BoxDecoration(
        color: Color.alphaBlend(
          Theme.of(context).colorScheme.primary.withOpacity(0.11),
          Theme.of(context).colorScheme.surface,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          verticalSpacing(pageHeight * 0.03),
          Icon(
            Icons.share_location,
            color: Theme.of(context).colorScheme.secondary,
            size: pageHeight * 0.048,
          ),
          verticalSpacing(pageHeight * 0.02),
          Text(
            'Location Sharing',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          verticalSpacing(pageHeight * 0.01),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: pageWidth * 0.05),
            child: Text(
              infoLocation,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
          verticalSpacing(pageHeight * 0.04),
          OptionSelector(
            icon: Icons.description_outlined,
            text: reason == "" ? "Reason" : reason,
            index: 0,
            changeReason: _setValues,
          ),
          verticalSpacing(pageHeight * 0.02),
          OptionSelector(
            icon: Icons.timer_outlined,
            text: duration == const Duration(minutes: 0)
                ? 'Duration'
                : displayDuration(duration),
            index: 1,
            changeReason: _setValues,
          ),
          const Spacer(),
          Row(
            children: [
              horizontalSpacing(pageWidth * 0.045),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              const Spacer(),
              FilledButton(
                onPressed: () {
                  if (reason == "" || duration == const Duration(minutes: 0)) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Alert!"),
                            content: const Text("Please enter the details"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("OK"))
                            ],
                          );
                        });
                  } else {
                    Navigator.pop(context);
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
                          return LocationContacts(
                            reason: selectedReason,
                            duration: selectedDuration,
                          );
                        });
                  }
                },
                child: const Text('Next'),
              ),
              horizontalSpacing(pageWidth * 0.045),
            ],
          ),
          verticalSpacing(
            pageHeight * 0.025,
          ),
        ],
      ),
    );
  }
}
