import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class Contacts with ChangeNotifier {
  List<Contact> _contacts = [];

  List<Contact> get contacts {
    return [..._contacts];
  }

  Future<void> getAllContacts() async {
    _contacts = await ContactsService.getContacts();

    notifyListeners();
  }
}
