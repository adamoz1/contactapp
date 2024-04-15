// ignore_for_file: must_be_immutable

import 'package:contactapp/controller/category_controller.dart';
import 'package:contactapp/screens/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCategory extends StatelessWidget {
  AddCategory({super.key});

  CategoryController c = Get.find<CategoryController>();
  final TextEditingController _category = TextEditingController();
  final TextEditingController _updateCategory = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainScreen(),
      appBar: AppBar(
        title: const Text("Add Category"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _category,
                  decoration: const InputDecoration(
                      hintText: "Category", border: OutlineInputBorder()),
                ),
                ElevatedButton(
                    onPressed: () {
                      c.addData(_category.text);
                      _category.text = "";
                    },
                    child: const Text("Submit Category")),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 300,
                  padding: const EdgeInsets.all(6),
                  child: Obx(() => ListView.builder(
                        itemCount: c.categoery_data.length,
                        itemBuilder: ((context, index) {
                          return Card(
                            child: Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                      c.categoery_data[index].category ?? ""),
                                )),
                                updateIcon(context, index,
                                    c.categoery_data[index].category),
                                deleteIcon(context, index)
                              ],
                            ),
                          );
                        }),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget updateIcon(context, index, name) {
    return IconButton(
        onPressed: () {
          _updateCategory.text = name;
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Update Data"),
                  content: TextField(
                    controller: _updateCategory,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel")),
                    TextButton(
                        onPressed: () {
                          c.updateData(_updateCategory.text, index);
                          _updateCategory.text = "";
                          Navigator.pop(context);
                        },
                        child: const Text("Ok"))
                  ],
                );
              });
        },
        icon: const Icon(Icons.edit_calendar));
  }

  Widget deleteIcon(context, index) {
    return IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Confirmation"),
                  content: const Text("Are you sure to delete category?"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel")),
                    TextButton(
                        onPressed: () {
                          c.deleteData(index);
                          Navigator.pop(context);
                        },
                        child: const Text("Ok"))
                  ],
                );
              });
        },
        icon: const Icon(Icons.delete));
  }
}
