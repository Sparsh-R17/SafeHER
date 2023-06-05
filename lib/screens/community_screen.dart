import 'package:flutter/material.dart';

import '../widgets/item_card.dart';

class CommunityScreen extends StatefulWidget {
  static const routeName = '/community-screen';
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final items = [
    {
      'itemName': "Pocket Knife",
      'amt': "Rs. 500",
      'img_url': "assets/png/pocket_knife.png"
    },
    {
      'itemName': "Self Defense Kit",
      'amt': "Rs. 300",
      'img_url': "assets/png/self_defence.png"
    },
    {
      'itemName': "Pepper Spray",
      'amt': "Rs. 50",
      'img_url': "assets/png/pepper_spary.png"
    },
    {
      'itemName': "Safety Alarm",
      'amt': "Rs. 400",
      'img_url': "assets/png/safety_alarm.png"
    },
    {
      'itemName': "Tactical Pen",
      'amt': "Rs. 100",
      'img_url': "assets/png/tactical_pen.png"
    },
    {
      'itemName': "Monkey Fist",
      'amt': "Rs. 250",
      'img_url': "assets/png/monkey_fist.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    final pageWidth = MediaQuery.of(context).size.width;
    final pageHeight = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(tabs: [
            Tab(
              text: "Marketplace",
            ),
            Tab(
              text: "Content",
            )
          ]),
          title: Text(
            "Community",
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          leading: IconButton(
            icon: const Icon(Icons.navigate_before),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: TabBarView(children: [
          marketPlace(pageHeight, pageWidth),
          const Center(child: Text("Page is under construction!")),
        ]),
      ),
    );
  }

  Padding marketPlace(double pageHeight, double pageWidth) {
    return Padding(
      padding: EdgeInsets.only(
        top: pageHeight * 0.03875,
        left: pageWidth * 0.0472,
        right: pageWidth * 0.0472,
      ),
      child: GridView.builder(
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: pageHeight * 0.0275,
            crossAxisSpacing: pageWidth * 0.0388,
            crossAxisCount: 2,
            childAspectRatio: (pageWidth * 0.43) / (pageHeight * 0.2575),
          ),
          itemBuilder: (context, index) {
            return ItemCard(
              itemName: items[index]['itemName']!,
              amt: items[index]['amt']!,
              url: items[index]['img_url']!,
            );
          }),
    );
  }
}
