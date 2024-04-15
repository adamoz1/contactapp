import 'package:hive/hive.dart';

part 'contact.g.dart';

@HiveType(typeId: 2)
class Contact {
  @HiveField(0)
  String? firstname;

  @HiveField(1)
  String? lastname;

  @HiveField(2)
  String? mobile;

  @HiveField(3)
  String? email;

  @HiveField(4)
  String? category;

  @HiveField(5)
  String? imagePath;

  Contact(
      {required this.firstname,
      required this.lastname,
      required this.mobile,
      required this.email,
      required this.category,
      required this.imagePath});

  Contact.fromJson(Map<String, dynamic> json)
      : firstname = json['fname'],
        lastname = json['lname'],
        mobile = json['mobile'],
        email = json['email'],
        category = json['category'],
        imagePath = json['imagePath'];
}
