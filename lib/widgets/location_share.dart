import 'package:flutter/material.dart';

import '../utils/app_dimension.dart';
import 'option_selector.dart';

class LocationShare extends StatelessWidget {
  const LocationShare({super.key});

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
          const OptionSelector(
            icon: Icons.description_outlined,
            text: "Reason",
          ),
          verticalSpacing(pageHeight * 0.02),
          const OptionSelector(
            icon: Icons.timer_outlined,
            text: 'Duration',
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
                onPressed: () {},
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
