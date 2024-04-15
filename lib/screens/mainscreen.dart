import 'package:contactapp/screens/add_category.dart';
import 'package:contactapp/screens/add_contact.dart';
import 'package:contactapp/screens/show_contact.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: const Text('Add Category'),
              onTap: () {
                Navigator.pop(context);
                Get.to(() => AddCategory());
              },
            ),
            ListTile(
              title: const Text('Add Contact'),
              onTap: () {
                Navigator.pop(context);
                Get.to(() => AddContact());
              },
            ),
            ListTile(
              title: const Text('Show Contact'),
              onTap: () {
                Navigator.pop(context);
                Get.to(() => ShowContact());
              },
            ),
          ],
        ),
      ),
    );
  }
}
