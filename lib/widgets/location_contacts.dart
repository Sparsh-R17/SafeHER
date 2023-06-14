import 'package:flutter/material.dart';
import 'package:kavach/providers/contacts.dart';
import 'package:kavach/screens/location_share_screen.dart';
import 'package:kavach/utils/sos_fn.dart';
import 'package:provider/provider.dart';

import '../utils/app_dimension.dart';
import 'location_share.dart';

class LocationContacts extends StatefulWidget {
  final String reason;
  final Duration duration;
  const LocationContacts({
    super.key,
    required this.reason,
    required this.duration,
  });

  @override
  State<LocationContacts> createState() => _LocationContactsState();
}

List<String>? selected = List.empty(growable: true);
List<String> nos = List.empty(growable: true);
void _sendLocation(List<Map<String, String>> emergency) {
  for (var element in emergency) {
    if (selected!.contains(element["name"])) {
      nos.add(element['number']!);
    }
  }
  print(nos);
  shareLocation(nos, false, reason);
}

class _LocationContactsState extends State<LocationContacts> {
  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;
    final emergencyContacts =
        Provider.of<ContactProvider>(context).emergencyContacts;

    String infoLocation =
        "Emergency sharing begins if you don't react during your safety check.";

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
          verticalSpacing(pageHeight * 0.013),
          Text(
            'Location Sharing',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          verticalSpacing(pageHeight * 0.01),
          Padding(
            padding: EdgeInsets.only(
              left: pageWidth * 0.05,
              right: pageWidth * 0.05,
              bottom: pageHeight * 0.015,
            ),
            child: Text(
              infoLocation,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: pageWidth * 0.03),
            height: pageHeight * 0.29,
            child: emergencyContacts.isEmpty
                ? const Center(
                    child: Text('No Emergency Contacts Added'),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        emergencyContacts.length,
                        (index) {
                          return CheckboxListTile.adaptive(
                            value: selected!
                                .contains(emergencyContacts[index]["name"]),
                            onChanged: (value) {
                              setState(() {
                                if (selected!.contains(
                                    emergencyContacts[index]["name"])) {
                                  selected!.removeWhere(
                                    (element) =>
                                        element ==
                                        emergencyContacts[index]["name"],
                                  );
                                } else {
                                  selected!
                                      .add(emergencyContacts[index]["name"]!);
                                }
                              });
                              // print(selected);
                            },
                            title: Row(children: [
                              CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).colorScheme.tertiary,
                                radius: pageWidth * 0.04,
                                child: Text(
                                  emergencyContacts[index]["name"]!
                                      .characters
                                      .first,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onTertiary,
                                      ),
                                ),
                              ),
                              horizontalSpacing(pageWidth * 0.04),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    emergencyContacts[index]['name']!,
                                  ),
                                  Text(
                                    emergencyContacts[index]['number'] ??
                                        'No Number',
                                  ),
                                ],
                              ),
                            ]),
                          );
                        },
                      ),
                    ),
                  ),
          ),
          verticalSpacing(pageHeight * 0.01),
          Row(
            children: [
              horizontalSpacing(pageWidth * 0.045),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
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
                },
                child: const Text('Back'),
              ),
              const Spacer(),
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                  _sendLocation(emergencyContacts);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LocationShareScreen(
                                reason: reason,
                                duration: duration,
                                nos: nos,
                              )));
                },
                child: const Text("Start"),
              ),
              horizontalSpacing(pageWidth * 0.045),
            ],
          )
        ],
      ),
    );
  }
}
