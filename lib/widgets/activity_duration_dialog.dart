import 'package:flutter/material.dart';
import '/utils/app_dimension.dart';

class ActivityDurationDialog extends StatelessWidget {
  const ActivityDurationDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    DateTime currentTime = DateTime.now();
    int addHour = 1;
    int radioNum = 0;

    return StatefulBuilder(
      builder: (context, setState) {
        int hour =
            currentTime.hour >= 12 ? currentTime.hour - 12 : currentTime.hour;
        int min = currentTime.minute;
        String? notation;
        if (currentTime.hour >= 0 && currentTime.hour <= 11) {
          notation = "am";
        } else {
          notation = "pm";
        }

        return Dialog(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: pageHeight * 0.02),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Select Duration",
                  style: Theme.of(context).textTheme.titleLarge,
                  textScaleFactor: 0.9,
                ),
                verticalSpacing(pageHeight * 0.02),
                SizedBox(
                  height: pageHeight * 0.16,
                  child: ListView(
                    children: [
                      RadioListTile(
                        value: 0,
                        groupValue: radioNum,
                        onChanged: (value) {
                          setState(() {
                            radioNum = value!;
                          });
                        },
                        title: const Text("Until you turn off"),
                      ),
                      RadioListTile(
                        value: 1,
                        groupValue: radioNum,
                        onChanged: (value) {
                          setState(() {
                            radioNum = value!;
                          });
                        },
                        isThreeLine: true,
                        title: Row(
                          children: [
                            Text("For $addHour Hour"),
                            const Spacer(),
                            IconButton(
                              onPressed: addHour == 1 || radioNum == 0
                                  ? null
                                  : () {
                                      setState(() {
                                        addHour--;
                                        currentTime = currentTime
                                            .subtract(const Duration(hours: 1));
                                      });
                                    },
                              icon: const Icon(
                                Icons.remove,
                              ),
                            ),
                            IconButton(
                              onPressed: addHour >= 8 || radioNum == 0
                                  ? null
                                  : () {
                                      setState(() {
                                        addHour++;
                                        currentTime = currentTime
                                            .add(const Duration(hours: 1));
                                      });
                                    },
                              icon: const Icon(
                                Icons.add,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          "Until ${hour == 0 ? 12 : hour}:${min.toString().padLeft(2, '0')} $notation",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpacing(pageHeight * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () => Navigator.pop(context, "Duration"),
                        child: const Text("Cancel"),
                      ),
                      FilledButton(
                        onPressed: () {
                          if (radioNum == 0) {
                            Navigator.of(context).pop("Until you turn Off");
                          } else {
                            Navigator.of(context).pop(
                                "Until ${hour == 0 ? 12 : hour}:${min.toString().padLeft(2, '0')} $notation");
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
    );
  }
}
