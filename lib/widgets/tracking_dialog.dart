import 'package:flutter/material.dart';
import '../utils/app_dimension.dart';
import '../widgets/activity_tracker_dialog.dart';

import 'activity_duration_dialog.dart';

class TrackingDialog extends StatefulWidget {
  const TrackingDialog({super.key});

  @override
  State<TrackingDialog> createState() => _TrackingDialogState();
}

class _TrackingDialogState extends State<TrackingDialog> {
  List title = ["Choose Activity", "Duration"];

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;
    return Dialog(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: pageHeight * 0.02,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: pageHeight * 0.002,
              ),
              child: Text(
                "Enter Activity",
                style: Theme.of(context).textTheme.titleLarge,
                textScaleFactor: 0.9,
              ),
            ),
            verticalSpacing(pageHeight * 0.025),
            trackingCard(ctx: context, icon: Icons.hiking, index: 0),
            verticalSpacing(pageHeight * 0.01),
            trackingCard(ctx: context, icon: Icons.access_time, index: 1),
            verticalSpacing(pageHeight * 0.01),
            Padding(
              padding: EdgeInsets.only(
                right: pageWidth * 0.03,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed:
                        title[0] == "Choose Activity" || title[1] == "Duration"
                            ? null
                            : () {
                                print(title);
                              },
                    child: const Text("Done"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget trackingCard({
    required BuildContext ctx,
    required IconData icon,
    required int index,
  }) {
    final pageHeight = MediaQuery.of(ctx).size.height;
    final pageWidth = MediaQuery.of(ctx).size.width;
    return Container(
      height: pageHeight * 0.07,
      margin: EdgeInsets.symmetric(horizontal: pageWidth * 0.03),
      child: Card(
        color: Color.alphaBlend(
          Theme.of(context).colorScheme.surface,
          Theme.of(context).colorScheme.primary.withOpacity(0.05),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(7),
          onTap: () async {
            if (index == 1) {
              final res = await showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return const ActivityDurationDialog();
                },
              );
              setState(() {
                title[index] = res;
              });
            } else {
              final res = await showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return const ActivityTrackerDialog();
                },
              );
              setState(() {
                title[index] = res;
              });
            }
          },
          child: Row(
            children: [
              horizontalSpacing(pageWidth * 0.03),
              Icon(
                icon,
                color: Theme.of(ctx).colorScheme.primary,
              ),
              horizontalSpacing(pageWidth * 0.03),
              Text(title[index]),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(right: pageWidth * 0.01),
                child: Icon(
                  Icons.arrow_right,
                  color: Theme.of(ctx).colorScheme.onSurface,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
