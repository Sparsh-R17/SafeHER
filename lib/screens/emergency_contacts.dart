import 'package:flutter/material.dart';
import '../utils/app_dimension.dart';

import '../widgets/contact_list.dart';

class EmergencyContacts extends StatelessWidget {
  const EmergencyContacts({super.key});

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: pageHeight * 0.12,
            pinned: true,
            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true,
              title: Text('Emergency Contacts'),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                verticalSpacing(pageHeight * 0.04),
                Container(
                  width: pageWidth * 0.4,
                  margin: EdgeInsets.symmetric(
                    horizontal: pageWidth * 0.09,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add Contacts',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                      ),
                      IconButton.filled(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                      )
                    ],
                  ),
                ),
                verticalSpacing(pageHeight * 0.04),
                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: pageWidth * 0.06,
                    ),
                    child: Column(
                      children: List.generate(
                        20,
                        (index) => Padding(
                          padding: EdgeInsets.only(
                            bottom: pageHeight * 0.015,
                          ),
                          child: const ContactList(),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
