import 'package:flutter/material.dart';

class LocationShare extends StatelessWidget {
  const LocationShare({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: const Center(
        child: Text('Hello'),
      ),
    );
  }
}
