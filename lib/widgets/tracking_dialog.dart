import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kavach/utils/app_dimension.dart';

class TrackingDialog extends StatefulWidget {
  const TrackingDialog({super.key});

  @override
  State<TrackingDialog> createState() => _TrackingDialogState();
}

class _TrackingDialogState extends State<TrackingDialog> {
  List<Map> _activity = [
    {
      'text': "Running",
      'icon': FontAwesomeIcons.personRunning,
    },
    {
      'text': "Running",
      'icon': FontAwesomeIcons.personRunning,
    },
    {
      'text': "Running",
      'icon': FontAwesomeIcons.personRunning,
    },
    {
      'text': "Running",
      'icon': FontAwesomeIcons.personRunning,
    },
  ];

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
            trackingCard(
                ctx: context, title: "Choose Activity", icon: Icons.hiking),
            verticalSpacing(pageHeight * 0.01),
            trackingCard(
                ctx: context, title: "Duration", icon: Icons.access_time),
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
                      child: const Text("Cancel")),
                  TextButton(onPressed: () {}, child: const Text("Done")),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget trackingCard(
      {required BuildContext ctx,
      required String title,
      required IconData icon}) {
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
            final res = await showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop("Hello Buddy");
                      },
                      child: Text("Trial")),
                );
              },
            );
            print("MSG after pop - $res");
          },
          child: Row(
            children: [
              horizontalSpacing(pageWidth * 0.03),
              Icon(
                icon,
                color: Theme.of(ctx).colorScheme.primary,
              ),
              horizontalSpacing(pageWidth * 0.03),
              Text(title),
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
