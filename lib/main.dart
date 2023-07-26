// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:beats/VIEWS/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      themeMode: ThemeMode.dark,
    ) ;
  }
}