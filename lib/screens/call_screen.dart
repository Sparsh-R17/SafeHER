import 'package:flutter/material.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            surfaceTintColor: Colors.transparent,
            expandedHeight: pageHeight * 0.12,
            pinned: true,
            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true,
              title: Text('Call Screen'),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: pageHeight * 3.6,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
