import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todoapp/src/modul/auth/controller/bindings/auth_bindings.dart';
import 'package:todoapp/src/utils/root.dart';
import 'package:todoapp/src/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  AuthBinginds().dependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeController _themeController = Get.find();
    return SimpleBuilder(builder: (_) {
      return GetMaterialApp(
        title: 'todo app',
        home: Root(),
        theme: _themeController.theme,
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
