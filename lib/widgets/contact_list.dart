import 'package:flutter/material.dart';
import '../providers/contacts.dart';
import 'package:provider/provider.dart';

import '../utils/app_dimension.dart';

class ContactList extends StatelessWidget {
  final int index;
  const ContactList({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final pageWidth = MediaQuery.of(context).size.width;
    final provider = Provider.of<ContactProvider>(context);
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.amber,
          radius: pageWidth * 0.07,
          child: Text(
            provider.emergencyContacts[index]['name']!.characters.first,
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
              provider.emergencyContacts[index]['name']!,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(),
              textScaleFactor: 0.9,
            ),
            Text(
              provider.emergencyContacts[index]['number'] ?? 'No Number',
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
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    'Confirm Delete ?',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('No')),
                    TextButton(
                      onPressed: () {
                        provider.removeContacts(index);
                        Navigator.pop(context);
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                );
              },
            );
          },
          icon: const Icon(Icons.close),
          style: const ButtonStyle(
            splashFactory: NoSplash.splashFactory,
          ),
        )
      ],
    );
  }
}
