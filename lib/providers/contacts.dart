import 'dart:async';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class ContactProvider with ChangeNotifier {
  List<Contact> _contacts = [];
  var emergencyContacts = <Map<String, String>>[];
  Map<String, String>? backupContact;

  List<Contact> get contacts {
    return [..._contacts];
  }

  Future<void> getAllContacts() async {
    _contacts = await ContactsService.getContacts(withThumbnails: false);
    notifyListeners();
  }

  void addEmergency(List contactNames) async {
    emergencyContacts = [];
    int index = 0;
    await getAllContacts();
    for (var element in contactNames) {
      index = _contacts.indexWhere((ele) => ele.displayName == element);
      emergencyContacts.add({
        'name': element!,
        'number': _contacts.elementAt(index).phones![0].value!,
      });
    }
    notifyListeners();
  }

  void removeContacts(int index) {
    backupContact = emergencyContacts[index];
    emergencyContacts.removeAt(index);
    Timer(const Duration(seconds: 15), () {
      backupContact = null;
    });
    notifyListeners();
  }

  void recoverContact() {
    emergencyContacts.add(backupContact!);
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
