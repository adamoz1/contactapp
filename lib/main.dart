import 'dart:io';
import 'package:contactapp/controller/category_controller.dart';
import 'package:contactapp/controller/contact_controller.dart';
import 'package:contactapp/model/cat.dart';
import 'package:contactapp/model/category_model.dart';
import 'package:contactapp/model/contact.dart';
import 'package:contactapp/model/contact_model.dart';
import 'package:contactapp/screens/add_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await checkbox();
  HttpOverrides.global = MyHttpOverrides();
  Get.lazyPut(() => CategoryController());
  Get.lazyPut(() => ContactController());
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: AddCategory(),
  ));
}

checkbox() async {
  bool checkDB = Hive.isBoxOpen("user");
  if (!checkDB) {
    print("Db is not initialized");
    Hive.registerAdapter(CatAdapter());
    categoryModel.collection = await Hive.openBox<Cat>('user');
    Hive.registerAdapter(ContactAdapter());
    contactModel.collection = await Hive.openBox<Contact>('user1');
  } else {
    print("Db is initialized");
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
