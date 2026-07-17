import 'package:chat/models/contact_model.dart';
import 'package:chat/models/message_model.dart';
import 'package:hive/hive.dart';

class HiveCasheManager {
  static final HiveCasheManager _singleton = HiveCasheManager._internal();

  factory HiveCasheManager() {
    return _singleton;
  }

  HiveCasheManager._internal();

  Box<ContactModel>? contactBox;

  init() async {
    contactBox = await Hive.openBox<ContactModel>("contacts");
  }

  save(ContactModel contact) async {
    await init();
    if (contactBox != null && contactBox!.isOpen) {
      final result = contactBox!.get(contact.user.id);
      if (result == null) {
        await contactBox!.put(contact.user.id, contact);
      } else {
        result.messages.addAll(contact.messages);
        await contactBox!.put(contact.user.id, result);
      }
    }
  }


  update(String userid, Message msg) async {
    await init();
    if (contactBox != null && contactBox!.isOpen) {
      final contact = contactBox!.get(userid);
      contact?.messages.add(msg);
      await contactBox!.put(userid, contact!);
    }
  }

  updateLastSeen(String userid) async {
    await init();
    if (contactBox != null && contactBox!.isOpen) {
      final contact = contactBox!.get(userid);
      for (var i = 0; i < contact!.messages.length; i++) {
        contact.messages[i].seen = true;
      }
      await contactBox!.put(userid, contact);
    }
  }

  Future<List<ContactModel>> getAll() async {
    await init();
    if (contactBox != null && contactBox!.isOpen) {
      return contactBox!.values.toList();
    } else {
      return [];
    }
  }

  Future<ContactModel?> get(String userid) async {
    await init();
    if (contactBox != null && contactBox!.isOpen) {
      return contactBox!.get(userid);
    } else {
      return null;
    }
  }

  clearAll() async {
    await init();
    contactBox!.clear();
    contactBox = null;
  }
}
