import 'package:flutter/material.dart';

class CheckListScreen extends StatefulWidget {
  static const routeName = '/checklist';
  const CheckListScreen({super.key});

  @override
  State<CheckListScreen> createState() => _CheckListScreenState();
}

class _CheckListScreenState extends State<CheckListScreen> {
  List<Tab> myTabs = <Tab>[
    Tab(icon: Icon(Icons.star)),
    Tab(text: 'Daily'),
    Tab(icon: Icon(Icons.add)),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('CheckList Screen'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight * 0.75),
            child: SingleChildScrollView(
              child: TabBar(
                labelPadding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1,
                ),
                isScrollable: true,
                tabs: myTabs,
                onTap: (value) {
                  print(value);
                  setState(() {
                    if (value == myTabs.length - 1) {
                      myTabs.insert(
                        value,
                        const Tab(
                          text: 'Hello',
                        ),
                      );
                    }
                  });
                },
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: myTabs.map((Tab tab) {
            final String label = tab.text ?? ''.toLowerCase();
            return Text(
              'This is the $label tab',
              style: const TextStyle(fontSize: 36),
            );
          }).toList(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton.extended(
              onPressed: () {},
              icon: Icon(Icons.remove),
              label: Text('Remove'),
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
            ),
            FloatingActionButton.extended(
              onPressed: () {},
              icon: Icon(Icons.add),
              label: Text('Add'),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            ),
          ],
        ),
      ),
    );
  }
}
