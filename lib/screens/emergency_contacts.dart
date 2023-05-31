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
  }

  ScrollController scrollDirection = ScrollController();
  bool fabExtended = false;

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;
    TextEditingController contactController = TextEditingController();
    final emergencyContacts = Provider.of<Contacts>(context, listen: false);

    return Scaffold(
      body: CustomScrollView(
        controller: scrollDirection,
        slivers: [
          SliverAppBar(
            expandedHeight: pageHeight * 0.12,
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
                  child: Column(
                    children: List.generate(
                      20,
                      (index) => Padding(
                        padding: EdgeInsets.only(
                          bottom: pageHeight * 0.02,
                        ),
                        child: const ContactList(),
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
        onPressed: () async {
          await emergencyContacts.getAllContacts();

          addContactsDialog(
            context,
            pageWidth,
            pageHeight,
            contactController,
            emergencyContacts.contacts,
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
    List<Contact> emergencyContactsList,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
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
                        setState(() {
                          emergencyContactsList.removeWhere((element) {
                            return !element.displayName!.contains(value);
                          });
                        });
                        emergencyContactsList
                            .forEach((element) => print(element.displayName));
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
                        itemCount: emergencyContactsList.length,
                        itemBuilder: (context, index) {
                          return contactsSelection(
                            pageWidth,
                            emergencyContactsList,
                            index,
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
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text('Save'),
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
  }

  Widget contactsSelection(
    double pageWidth,
    List<Contact> emergencyContactsList,
    int index,
  ) {
    return CheckboxListTile.adaptive(
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      value: true,
      onChanged: (value) {},
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
  }

  void getContactPermission() async {
    if (await Permission.contacts.request().isDenied) {
      await Permission.contacts.request();
    }
  }
}
