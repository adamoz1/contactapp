import 'dart:io';

import 'package:contactapp/controller/category_controller.dart';
import 'package:contactapp/controller/contact_controller.dart';
import 'package:contactapp/model/contact.dart';
import 'package:contactapp/screens/mainscreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class ShowContact extends StatelessWidget {
  ShowContact({super.key});
  ContactController c = Get.find<ContactController>();
  CategoryController c1 = Get.find<CategoryController>();
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController filterdata = TextEditingController();
  late String _imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Details"),
        actions: [
          IconButton(
              onPressed: () {
                filterData(context);
              },
              icon: const Icon(Icons.search_rounded)),
          IconButton(
              onPressed: () {
                sortData(context);
              },
              icon: const Icon(Icons.sort))
        ],
      ),
      drawer: MainScreen(),
      body: Center(child: Obx(() {
        var filter = c.filter.value;
        var search = c.search.value;
        return ListView.builder(
          itemCount: c.contact_data.length,
          itemBuilder: (context, index) {
            if (filter == "" && search == "") {
              return Obx(() {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: (c.contact_data[index].imagePath != null
                          ? FileImage(File(c.contact_data[index].imagePath!))
                          : const AssetImage('')) as ImageProvider,
                    ),
                    title: Text("Name: ${c.contact_data[index].firstname}"),
                    subtitle:
                        Text("Contact no: ${c.contact_data[index].mobile}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            showDlog(index, context);
                          },
                          icon: const Icon(Icons.edit_calendar_outlined),
                        ),
                        IconButton(
                            onPressed: () {
                              c.deleteData(index);
                            },
                            icon: const Icon(Icons.delete))
                      ],
                    ),
                  ),
                );
              });
            } else if (filter == c.contact_data[index].category ||
                c.contact_data[index].firstname == search) {
              return Card(
                child: ListTile(
                  title: Text("Name: ${c.contact_data[index].firstname}"),
                  subtitle: Text("Contact no: ${c.contact_data[index].mobile}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          showDlog(index, context);
                        },
                        icon: const Icon(Icons.edit_calendar_outlined),
                      ),
                      IconButton(
                          onPressed: () {
                            c.deleteData(index);
                          },
                          icon: const Icon(Icons.delete))
                    ],
                  ),
                ),
              );
            }
            return null;
          },
        );
      })),
    );
  }

  showDlog(index, context) {
    Contact data = c.contact_data[index];
    fname.text = data.firstname ?? "";
    lname.text = data.lastname ?? "";
    mobile.text = data.mobile ?? "";
    email.text = data.email ?? "";
    _imagePath = data.imagePath ?? "";
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Update Data"),
            content: Column(
              children: [
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
                TextField(
                  controller: lname,
                  decoration: const InputDecoration(
                      hintText: "Last Name", border: OutlineInputBorder()),
                ),
                TextField(
                  controller: mobile,
                  decoration: const InputDecoration(
                      hintText: "Mobile", border: OutlineInputBorder()),
                ),
                TextField(
                  controller: email,
                  decoration: const InputDecoration(
                      hintText: "Email", border: OutlineInputBorder()),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    c.updateData(fname.text, lname.text, mobile.text,
                        email.text, index, _imagePath);
                    Navigator.pop(context);
                  },
                  child: const Text("Ok")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"))
            ],
          );
        });
  }

  Future<void> selectImage() async {
    final picker = ImagePicker();
    // print("right");
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // setState(() {
      _imagePath = pickedFile.path;
      // });
    }
  }

  sortData(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 300,
          child: ListView.builder(
            itemCount: c1.categoery_data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Card(
                    child: SizedBox(
                  height: 70,
                  child: Center(
                    child: Text(
                      c1.categoery_data[index].category,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                )),
                onTap: () {
                  c.changefilter(c1.categoery_data[index].category);
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  filterData(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Filter Data"),
            content: TextField(
              controller: filterdata,
              decoration: const InputDecoration(
                  hintText: "Enter FirstName", border: OutlineInputBorder()),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    c.searchData(filterdata.text);
                    filterdata.text = "";
                    Navigator.pop(context);
                  },
                  child: const Text("Filter"))
            ],
          );
        });
  }
}
