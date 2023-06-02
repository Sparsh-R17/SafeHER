import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  const InfoTile({
    super.key,
    required this.pageHeight,
    required this.icon,
    required this.data,
    required this.med,
    this.route,
    this.subtitle,
  });

  final double pageHeight;
  final IconData icon;
  final String data;
  final String? subtitle;
  final String? route;
  final bool med;

  @override
  Widget build(BuildContext context) {
    final pageWidth = MediaQuery.of(context).size.width;
    return ListTile(
        leading: Padding(
          padding: med
              ? EdgeInsets.only(left: pageWidth * 0.01, right: pageWidth * 0.02)
              : EdgeInsets.zero,
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
            size: pageHeight * 0.03,
          ),
        ),
        title: Text(
          data,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: med ? FontWeight.w500 : FontWeight.normal),
        ),
        subtitle: med
            ? Text(
                subtitle!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              )
            : null,
        onTap: () {
          if (med == false) {
            Navigator.pushNamed(context, route!);
          }
        });
  }
}
