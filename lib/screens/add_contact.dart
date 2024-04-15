import 'dart:io';

import 'package:contactapp/controller/category_controller.dart';
import 'package:contactapp/controller/contact_controller.dart';
import 'package:contactapp/model/cat.dart';
import 'package:contactapp/screens/mainscreen.dart';
import 'package:contactapp/screens/show_contact.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class AddContact extends StatelessWidget {
  AddContact({super.key});
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  var category = Cat().obs;
  ContactController c = Get.find<ContactController>();
  CategoryController c1 = Get.find<CategoryController>();
  late String _imagePath = "";

  Future<void> selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // setState(() {
      _imagePath = pickedFile.path;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MainScreen(),
        appBar: AppBar(
          title: const Text("Add Contact"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              GestureDetector(
                onTap: selectImage,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  // ignore: unnecessary_null_comparison
                  child: _imagePath != null
                      ? ClipOval(
                          child: !kIsWeb
                              ? Image(
                                  image: Image.file(
                                    File(_imagePath),
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ).image,
                                )
                              : Image.network(
                                  _imagePath,
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                        )
                      : Icon(
                          Icons.camera_alt,
                          size: 60,
                          color: Colors.grey[400],
                        ),
                ),
              ),
              TextField(
                controller: fname,
                decoration: const InputDecoration(
                    hintText: "First Name", border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: lname,
                decoration: const InputDecoration(
                    hintText: "Last Name", border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: mobile,
                decoration: const InputDecoration(
                    hintText: "Mobile No. ", border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: email,
                decoration: const InputDecoration(
                    hintText: "Email", border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() {
                if (c1.categoery_data.isNotEmpty) {
                  category.value = c1.categoery_data[0];
                  return DropdownButtonFormField(
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                    value: c1.categoery_data[0],
                    onChanged: (newValue) {
                      category.value = newValue! as Cat;
                    },
                    items: c1.categoery_data.isEmpty
                        ? [const DropdownMenuItem(child: Text("No data Found"))]
                        : c1.categoery_data
                            .map(
                              (data) {
                                return DropdownMenuItem(
                                  value: data,
                                  child: Text(data.category),
                                );
                              },
                            )
                            .toSet()
                            .toList(),
                  );
                } else {
                  return Container();
                }
              }),
              c1.categoery_data.isNotEmpty
                  ? ElevatedButton(
                      onPressed: () {
                        if (fname.text == "" ||
                            lname.text == "" ||
                            email.text == "" ||
                            mobile.text == "" ||
                            category.value.category == "") {
                          return;
                        }
                        c.addData(fname.text, lname.text, mobile.text,
                            email.text, category.value.category, _imagePath);
                        fname.text = "";
                        lname.text = "";
                        email.text = "";
                        mobile.text = "";
                        category.value = c1.categoery_data[0];
                        Get.to(() => ShowContact());
                        // _category.text = "";
                      },
                      child: const Text("Submit Contact"))
                  : const Text("No Category Found"),
              const SizedBox(
                height: 20,
              ),
            ]),
          ),
        ));
  }
}
