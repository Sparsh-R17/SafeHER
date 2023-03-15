import 'package:flutter/material.dart';
import '../utils/app_dimension.dart';
import '../widgets/current_map.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;
  

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    print('avatar selected');
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: pageHeight * 0.015,
                      left: pageWidth * 0.03,
                    ),
                    child: CircleAvatar(
                      minRadius: pageWidth * 0.08,
                      maxRadius: pageWidth * 0.11,
                      backgroundColor: Color.alphaBlend(
                        Theme.of(context).colorScheme.primary.withOpacity(0.08),
                        Theme.of(context).colorScheme.surface,
                      ),
                      child: CircleAvatar(
                        minRadius: pageWidth * 0.06,
                        maxRadius: pageWidth * 0.09,
                        foregroundImage:
                            const AssetImage('assets/png/avatar_1.png'),
                      ),
                    ),
                  ),
                ),
                horizontalSpacing(pageWidth * 0.03),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpacing(pageHeight * 0.015),
                    Text(
                      'Hello',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Ayushri Bhuyan',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              ],
            ),
            verticalSpacing(pageHeight * 0.05),
            const Expanded(
              child: CurrentMap(

              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(
          bottom: pageHeight * 0.01,
        ),
        width: pageWidth * 0.35,
        height: pageHeight * 0.08,
        child: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).colorScheme.errorContainer,
          onPressed: () {},
          icon: Icon(
            Icons.crisis_alert,
            size: pageHeight * 0.04,
          ),
          label: Text(
            'SOS',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            pageIndex = index;
          });
        },
        selectedIndex: pageIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.phone_callback,
            ),
            label: 'Fake Call',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.share_location,
            ),
            label: 'Location',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.support_agent,
            ),
            label: 'Help Desk',
          ),
        ],
      ),
    );
  }
}
