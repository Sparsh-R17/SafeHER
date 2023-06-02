import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class ContactProvider with ChangeNotifier {
  List<Contact> _contacts = [];

  List<Contact> get contacts {
    return [..._contacts];
  }

  Future<void> getAllContacts() async {
    _contacts = await ContactsService.getContacts(withThumbnails: false);
    notifyListeners();
  }

  void clearAndSearchContacts(String value) async {
    await getAllContacts();
    searchContacts(value);
    notifyListeners();
  }

  void searchContacts(String value) {
    _contacts.retainWhere((element) {
      return element.displayName!.toLowerCase().contains(
            value.toLowerCase(),
          );
    });
    notifyListeners();
  }
}
