import 'package:contactapp/model/contact.dart';
import 'package:hive/hive.dart';

class ContactModel {
  late final Box collection;

  getList() {
    print(collection.values.toList());
    return collection.values.toList();
  }

  addContact(fname, lname, mobile, email, category, index, imagePath) {
    if (fname == "" ||
        lname == "" ||
        email == "" ||
        mobile == "" ||
        category == "" ||
        imagePath == "") {
      return false;
    } else {
      Contact val = Contact.fromJson({
        "fname": fname,
        "lname": lname,
        "mobile": mobile,
        "email": email,
        "category": category,
        "imagePath": imagePath
      });
      collection.add(val);
      // collection.put(index, val);
      print(collection.values.toList());
      return true;
    }
  }

  updateContact(fname, lname, mobile, email, index, imagePath) {
    Contact c = collection.getAt(index);
    c.firstname = fname;
    c.lastname = lname;
    c.mobile = mobile;
    c.email = email;
    c.imagePath = imagePath;
    collection.put(index, c);
  }

  delContact(index) {
    collection.deleteAt(index);
    // collection.delete(collection.keyAt(index));
  }
}

ContactModel contactModel = ContactModel();
