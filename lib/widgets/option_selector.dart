import 'package:flutter/material.dart';

import '../utils/app_dimension.dart';

class OptionSelector extends StatelessWidget {
  final IconData icon;
  final String text;

  const OptionSelector({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        if (text == 'Reason') {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Choose Your Reason'),
                alignment: Alignment.center,
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ],
              );
            },
          );
        } else {}
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
                icon,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            horizontalSpacing(pageWidth * 0.01),
            Text(
              text,
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
