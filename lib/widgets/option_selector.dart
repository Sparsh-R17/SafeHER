import 'package:flutter/material.dart';

import '../utils/app_dimension.dart';

class OptionSelector extends StatefulWidget {
  final IconData icon;
  final String text;
  final int index;
  final void Function(String reason, Duration duration)? changeReason;

  const OptionSelector({
    super.key,
    required this.icon,
    required this.text,
    required this.index,
    this.changeReason,
  });

  @override
  State<OptionSelector> createState() => _OptionSelectorState();
}

List reasons = [
  {
    "title": "Walking Alone",
    "icon": Icons.hiking_outlined,
  },
  {
    "title": "Travelling in Cab",
    "icon": Icons.local_taxi_outlined,
  },
  {
    "title": "Public Transport",
    "icon": Icons.hail_outlined,
  },
];

List durations = [
  "15 Minutes",
  "30 Minutes",
  "Manually End",
  "Custom",
];
String selectedReason = "Walking Alone";
Duration selectedDuration = const Duration(minutes: 0);
TextEditingController custom = TextEditingController();
@override
void dispose() {
  custom.dispose();
}

class _OptionSelectorState extends State<OptionSelector> {
  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;
    bool isEnabled = false;
    return GestureDetector(
      onTap: () {
        if (widget.index == 0) {
          showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return AlertDialog(
                    title: const Text(
                      'Choose Your Reason',
                      textAlign: TextAlign.center,
                    ),
                    alignment: Alignment.center,
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(
                            () {
                              selectedReason = "Walking Alone";
                            },
                          );
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          if (isEnabled == true) {
                            selectedReason = custom.text;
                          }
                          print(selectedReason);
                          widget.changeReason!(
                              selectedReason, selectedDuration);
                          Navigator.pop(context);
                        },
                        child: const Text('Done'),
                      ),
                    ],
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            children: List.generate(
                              reasons.length,
                              (index) {
                                return RadioListTile.adaptive(
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                  visualDensity: const VisualDensity(
                                    horizontal: VisualDensity.minimumDensity,
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                  value: reasons[index]['title'],
                                  groupValue: selectedReason,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedReason = val!;
                                      isEnabled = false;
                                      print("This - $selectedReason");
                                    });
                                  },
                                  title: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        reasons[index]["icon"],
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      horizontalSpacing(pageWidth * 0.035),
                                      Text(
                                        reasons[index]['title'],
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          RadioListTile.adaptive(
                            contentPadding: EdgeInsets.zero,
                            controlAffinity: ListTileControlAffinity.trailing,
                            value: "Custom",
                            groupValue: selectedReason,
                            onChanged: (val) {
                              setState(
                                () {
                                  isEnabled = true;
                                },
                              );
                            },
                            title: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.edit_note_outlined,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                horizontalSpacing(pageWidth * 0.035),
                                Text(
                                  "Custom",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: pageHeight * 0.05,
                            child: TextField(
                              controller: custom,
                              enabled: isEnabled,
                              decoration: InputDecoration(
                                  hintText: "Custom",
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: pageHeight * 0.01,
                                      horizontal: pageWidth * 0.03),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.zero)),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        } else if (widget.index == 1) {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  insetPadding: EdgeInsets.symmetric(
                      vertical: pageHeight * 0.2787,
                      horizontal: pageWidth * 0.158),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: pageHeight * 0.03,
                      horizontal: pageWidth * 0.04,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Choose Your Duration",
                          style: Theme.of(context).textTheme.headlineSmall!,
                          // textAlign: TextAlign.center,
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: durations.length,
                              padding: EdgeInsets.only(top: pageHeight * 0.015),
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    ListTile(
                                      visualDensity: const VisualDensity(
                                          vertical:
                                              VisualDensity.minimumDensity),
                                      title: Text(durations[index]),
                                      onTap: () async {
                                        print(durations[index]);
                                        if (index == 0) {
                                          selectedDuration =
                                              const Duration(minutes: 15);
                                        } else if (index == 1) {
                                          selectedDuration =
                                              const Duration(minutes: 30);
                                        } else if (index == 2) {
                                          //TODO: Need to make Manually End - Boolean
                                          selectedDuration =
                                              const Duration(days: 1);
                                        } else {
                                          Navigator.of(context).pop();
                                          var time = await showTimePicker(
                                              context: context,
                                              builder:
                                                  (context, Widget? child) {
                                                return MediaQuery(
                                                  data: MediaQuery.of(context)
                                                      .copyWith(
                                                          alwaysUse24HourFormat:
                                                              true),
                                                  child: child!,
                                                );
                                              },
                                              initialTime:
                                                  const TimeOfDay(hour: 0, minute: 0),
                                              initialEntryMode:
                                                  TimePickerEntryMode
                                                      .inputOnly);
                                          selectedDuration = Duration(
                                            hours: time?.hour ?? 0,
                                            minutes: time?.minute ?? 0,
                                          );
                                        }
                                        print(selectedDuration);
                                        widget.changeReason!(
                                            selectedReason, selectedDuration);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    if (index != 3) const Divider(),
                                  ],
                                );
                              }),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel"),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: pageWidth * 0.06,
        ),
        height: pageHeight * 0.075,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: pageWidth * 0.04,
              ),
              child: Icon(
                widget.icon,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            horizontalSpacing(pageWidth * 0.01),
            Text(
              widget.text,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: pageWidth * 0.04,
              ),
              child: Icon(
                Icons.keyboard_arrow_right_rounded,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
