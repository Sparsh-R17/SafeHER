import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/app_dimension.dart';

class ActivityTrackerDialog extends StatefulWidget {
  const ActivityTrackerDialog({super.key});

  @override
  State<ActivityTrackerDialog> createState() => _ActivityTrackerDialogState();
}

class _ActivityTrackerDialogState extends State<ActivityTrackerDialog> {
  int radioSelected = 0;
  TextEditingController activityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;
    List<Map> activity = [
      {
        'text': "Running",
        'icon': FontAwesomeIcons.personRunning,
      },
      {
        'text': "Gym",
        'icon': Icons.fitness_center,
      },
      {
        'text': "Cycling",
        'icon': FontAwesomeIcons.personRunning,
      },
      {
        'text': "Custom",
        'icon': Icons.edit,
      },
    ];

    return ScaffoldMessenger(
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: StatefulBuilder(
              builder: (context, setState) {
                return Dialog(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: pageHeight * 0.02,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Choose an Activity",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        verticalSpacing(pageHeight * 0.015),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: pageWidth * 0.05),
                          child: SizedBox(
                            height: pageHeight * 0.25,
                            child: ListView.builder(
                              itemCount: activity.length,
                              itemBuilder: (context, index) {
                                return RadioListTile(
                                  contentPadding: EdgeInsets.zero,
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                  value: index,
                                  groupValue: radioSelected,
                                  onChanged: (value) {
                                    setState(() {
                                      radioSelected = value!;
                                    });
                                  },
                                  title: Row(
                                    children: [
                                      Icon(
                                        activity[index]['icon'],
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      horizontalSpacing(pageWidth * 0.025),
                                      Text(activity[index]['text']),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        verticalSpacing(pageHeight * 0.015),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: pageWidth * 0.05,
                          ),
                          child: TextField(
                            controller: activityController,
                            enabled: radioSelected == 3,
                            decoration: const InputDecoration(
                              label: Text("Custom Activity"),
                              hintText: "Enter Activity",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        verticalSpacing(pageHeight * 0.03),
                        if (MediaQuery.of(context).viewInsets.bottom == 0)
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: pageWidth * 0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                OutlinedButton(
                                  onPressed: () =>
                                      Navigator.pop(context, "Choose Activity"),
                                  child: const Text("Cancel"),
                                ),
                                FilledButton(
                                  onPressed: () {
                                    if (radioSelected == 3) {
                                      if (activityController.text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .errorContainer,
                                            content: Text(
                                              "Custom Field Cannot be Empty",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onErrorContainer,
                                              ),
                                            ),
                                            closeIconColor: Theme.of(context)
                                                .colorScheme
                                                .onErrorContainer,
                                            showCloseIcon: true,
                                          ),
                                        );
                                      } else {
                                        Navigator.pop(
                                            context, activityController.text);
                                      }
                                    } else {
                                      Navigator.of(context)
                                          .pop(activity[radioSelected]['text']);
                                    }
                                  },
                                  child: const Text("Done"),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
