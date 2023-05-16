import 'package:flutter/material.dart';

import '../utils/app_dimension.dart';

class ContactList extends StatelessWidget {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context) {
    final pageWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.amber,
          radius: pageWidth * 0.07,
          child: Text(
            'A',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
          ),
        ),
        horizontalSpacing(pageWidth * 0.04),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Akash P',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(),
              textScaleFactor: 0.9,
            ),
            Text(
              '+91 9747016882',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).colorScheme.outline,
                  ),
              textScaleFactor: 1.2,
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.close),
          style: const ButtonStyle(
            splashFactory: NoSplash.splashFactory,
          ),
        )
      ],
    );
  }
}
