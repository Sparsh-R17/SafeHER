// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String itemName;
  final String amt;
  final String url;
  const ItemCard({
    super.key,
    required this.itemName,
    required this.amt,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    final pageWidth = MediaQuery.of(context).size.width;
    final pageHeight = MediaQuery.of(context).size.height;
    return Container(
      height: pageHeight * 0.2575,
      width: pageWidth * 0.43,
      padding: EdgeInsets.only(
        top: pageHeight * 0.0086,
        right: pageWidth * 0.02,
        left: pageWidth * 0.02,
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(18)),
      child: Column(
        children: [
          Container(
            height: pageHeight * 0.165,
            width: pageWidth * 0.41,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.asset(
              url,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: pageWidth * 0.015, top: pageHeight * 0.025),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      itemName,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .apply(fontSizeFactor: 1.2),
                    ),
                    Text(
                      amt,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(
                              color: Theme.of(context).colorScheme.outline)
                          .apply(fontSizeFactor: 1.1),
                    )
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.navigate_next,
                  size: pageWidth * 0.077,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
