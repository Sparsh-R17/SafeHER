import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../providers/contacts.dart';
import '../utils/app_dimension.dart';
import '../widgets/contact_list.dart';

class EmergencyContacts extends StatefulWidget {
  const EmergencyContacts({super.key});
  static const routeName = '/emergency-contacts';

  @override
  State<EmergencyContacts> createState() => _EmergencyContactsState();
}

class _EmergencyContactsState extends State<EmergencyContacts> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollDirection.addListener(() {
      if (scrollDirection.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          fabExtended = false;
        });
      } else {
        setState(() {
          fabExtended = true;
        });
      }
    });
    getContactPermission();
    Provider.of<ContactProvider>(context, listen: false).getAllContacts();
  }

  void fetchContacts() {
    Provider.of<ContactProvider>(context, listen: false).getAllContacts();
  }

  ScrollController scrollDirection = ScrollController();
  bool fabExtended = false;
  int editedStringLength = 0;

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;
    TextEditingController contactController = TextEditingController();
    final contact = Provider.of<ContactProvider>(context);
    List<String?> selectedContact = Provider.of<ContactProvider>(context)
        .emergencyContacts
        .map((e) => e['name'])
        .toList();

    return Scaffold(
      body: CustomScrollView(
        controller: scrollDirection,
        slivers: [
          SliverAppBar(
            expandedHeight: pageHeight * 0.14,
            pinned: true,
            titleSpacing: pageWidth * 0.2,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'Emergency Contacts',
                textScaleFactor: 0.9,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  width: pageWidth * 0.4,
                  margin: EdgeInsets.symmetric(
                    horizontal: pageWidth * 0.09,
                  ),
                  // child: const Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Add Contacts',
                  //       style:
                  //           Theme.of(context).textTheme.headlineSmall!.copyWith(
                  //                 color: Theme.of(context)
                  //                     .colorScheme
                  //                     .onSurfaceVariant,
                  //               ),
                  //     ),
                  //     IconButton.filled(
                  //       onPressed: () {
                  //         addContactsDialog(
                  //           context,
                  //           pageWidth,
                  //           pageHeight,
                  //           contactController,
                  //         );
                  //       },
                  //       icon: const Icon(Icons.add),
                  //     ),
                  //   ],
                  // ),
                ),
                verticalSpacing(pageHeight * 0.035),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: pageWidth * 0.06,
                  ),
                  child: contact.emergencyContacts.isEmpty
                      ? Padding(
                          padding: EdgeInsets.only(top: pageHeight * 0.27),
                          child: const Center(
                            child: Text('No Emergency Contacts Added'),
                          ),
                        )
                      : Column(
                          children: List.generate(
                            contact.emergencyContacts.length,
                            (index) => Padding(
                              padding: EdgeInsets.only(
                                bottom: pageHeight * 0.02,
                              ),
                              child: ContactList(index: index),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          addContactsDialog(
            context,
            pageWidth,
            pageHeight,
            contactController,
            selectedContact,
          );
        },
        label: Text(
          'Add Contacts',
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer),
        ),
        icon: const Icon(Icons.add),
        isExtended: !fabExtended,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
    );
  }

  Future<dynamic> addContactsDialog(
    BuildContext context,
    double pageWidth,
    double pageHeight,
    TextEditingController contactController,
    List<String?> _selectedContact,
  ) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Consumer<ContactProvider>(
          builder: (context, value, _) {
            return Dialog(
              backgroundColor: Color.alphaBlend(
                Theme.of(context).colorScheme.primary.withOpacity(0.11),
                Theme.of(context).colorScheme.surface,
              ),
              insetPadding: EdgeInsets.symmetric(
                horizontal: pageWidth * 0.07,
                vertical: pageHeight * 0.08,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: pageWidth * 0.05,
                ),
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: pageHeight * 0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpacing(pageHeight * 0.025),
                        TextField(
                          controller: contactController,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(
                              Icons.search,
                            ),
                            hintText: 'Search Contacts',
                          ),
                          onChanged: (value) {
                            if (editedStringLength == 0) {
                              editedStringLength = value.length;
                              Provider.of<ContactProvider>(context,
                                      listen: false)
                                  .searchContacts(value);
                            } else {
                              if (value.length < editedStringLength) {
                                editedStringLength = value.length;
                                Provider.of<ContactProvider>(context,
                                        listen: false)
                                    .clearAndSearchContacts(value);
                              } else {
                                editedStringLength = value.length;
                                Provider.of<ContactProvider>(context,
                                        listen: false)
                                    .searchContacts(value);
                              }
                            }
                          },
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                        ),
                        verticalSpacing(pageHeight * 0.025),
                        // if (MediaQuery.of(context).viewInsets.bottom == 0)
                        SizedBox(
                          height: pageHeight * 0.6,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: value.contacts.length,
                            itemBuilder: (context, index) {
                              return contactsSelection(
                                pageWidth,
                                value.contacts,
                                index,
                                _selectedContact,
                              );
                            },
                          ),
                        ),
                        const Spacer(),
                        // if (MediaQuery.of(context).viewInsets.bottom == 0)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                value.addEmergency(_selectedContact);
                                Navigator.pop(context);
                                fetchContacts();
                              },
                              child: const Text('Save'),
                            )
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget contactsSelection(
    double pageWidth,
    List<Contact> emergencyContactsList,
    int index,
    List<String?> _selectedContact,
  ) {
    return StatefulBuilder(
      builder: (context, setState) {
        return CheckboxListTile.adaptive(
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          value: _selectedContact
              .contains(emergencyContactsList[index].displayName),
          onChanged: (value) {
            setState(
              () {
                if (_selectedContact
                    .contains(emergencyContactsList[index].displayName)) {
                  _selectedContact.removeWhere((element) =>
                      element == emergencyContactsList[index].displayName);
                } else {
                  _selectedContact
                      .add(emergencyContactsList[index].displayName!);
                }
              },
            );
          },
          title: Row(
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                radius: pageWidth * 0.04,
                child: Text(
                  emergencyContactsList[index].displayName!.characters.first,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onTertiary,
                      ),
                ),
              ),
              horizontalSpacing(pageWidth * 0.03),
              SizedBox(
                width: pageWidth * 0.5,
                child: Text(
                  emergencyContactsList[index].displayName!,
                  overflow: TextOverflow.fade,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void getContactPermission() async {
    if (await Permission.contacts.request().isDenied) {
      await Permission.contacts.request();
    }
  }
}
