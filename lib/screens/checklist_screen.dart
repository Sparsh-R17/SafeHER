import 'package:flutter/material.dart';

import '../widgets/item_checklist_tile.dart';

class CheckListScreen extends StatefulWidget {
  static const routeName = '/checklist';
  const CheckListScreen({super.key});

  @override
  State<CheckListScreen> createState() => _CheckListScreenState();
}

class _CheckListScreenState extends State<CheckListScreen>
    with TickerProviderStateMixin {
  final List<Tab> _myTabs = <Tab>[
    const Tab(icon: Icon(Icons.star)),
    const Tab(text: 'Daily'),
    const Tab(icon: Icon(Icons.add)),
  ];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _myTabs.length, vsync: this);
  }

  int pageIndex = 0;

  final List<List<String>> _items = [
    [],
    [],
    [],
  ];

  List<List<bool>> isSelected = [[], [], []];

  final TextEditingController _tabNameController = TextEditingController();

  final TextEditingController _itemNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _tabNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageWidth = MediaQuery.of(context).size.width;
    final pageHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checklist Screen'),
        bottom: TabBar(
          controller: _tabController,
          tabs: _myTabs,
          isScrollable: true,
          labelPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.09,
          ),
          onTap: (value) {
            setState(() {
              pageIndex = value;
              if (value == _myTabs.length - 1) {
                pageIndex = 0;
                _tabController = TabController(
                  length: _myTabs.length,
                  vsync: this,
                  initialIndex: 0,
                );
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Enter Tab name'),
                      content: TextField(
                        controller: _tabNameController,
                        decoration:
                            const InputDecoration(hintText: 'Enter Tab Name'),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                            onPressed: () {
                              if (_tabNameController.text.isNotEmpty) {
                                _myTabs.insert(
                                  _myTabs.length - 1,
                                  Tab(text: _tabNameController.text),
                                );
                                _tabController = TabController(
                                  length: _myTabs.length,
                                  vsync: this,
                                  initialIndex: _myTabs.length - 2,
                                );
                                pageIndex = _myTabs.length - 2;
                                _items.insert(_myTabs.length - 1, []);
                                isSelected.insert(_myTabs.length - 1, []);
                                Navigator.pop(context);
                                _tabNameController.clear();
                              }
                            },
                            child: const Text('Done'))
                      ],
                    );
                  },
                );
              }
            });
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: pageWidth * 0.04,
          vertical: pageHeight * 0.01,
        ),
        child: _items[pageIndex].isEmpty
            ? Center(
                child: Text(
                  'No items added in the List.',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                ),
              )
            : ItemChecklistTile(items: _items, pageIndex: pageIndex,isSelected : isSelected),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (pageIndex != 0 && pageIndex != 1)
            FloatingActionButton.extended(
              heroTag: 'RemoveTag',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Confirm Deletion'),
                      content: Text(
                          'Do you want to remove ${_myTabs[pageIndex].text} Tab ?'),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('No')),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                _myTabs.removeAt(pageIndex);
                                _tabController = TabController(
                                  length: _myTabs.length,
                                  vsync: this,
                                  initialIndex: 0,
                                );
                                pageIndex = 0;
                              });
                              Navigator.pop(context);
                            },
                            child: const Text('Yes'))
                      ],
                    );
                  },
                );
              },
              label: Text(
                'Remove Tab',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              icon: Icon(
                Icons.remove,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
            ),
          FloatingActionButton.extended(
            heroTag: 'AddTag',
            onPressed: () {
              setState(() {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Enter Item'),
                      content: TextField(
                        controller: _itemNameController,
                        decoration: InputDecoration(
                          hintText: 'Item Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      actions: [
                        IconButton(
                          onPressed: () {
                            _items[pageIndex].add(_itemNameController.text);
                            isSelected[pageIndex].add(false);
                            Navigator.pop(context);
                            _itemNameController.clear();
                          },
                          icon: Icon(
                            Icons.send,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )
                      ],
                    );
                  },
                );
              });
            },
            label: Text(
              'Add Item',
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            icon: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          )
        ],
      ),
    );
  }
}
