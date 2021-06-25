import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:indoor_positioning_visitor/src/common/app_init.dart';
import 'package:indoor_positioning_visitor/src/common/strings.dart';
import 'package:indoor_positioning_visitor/src/routes/app_pages.dart';
import 'package:indoor_positioning_visitor/src/routes/routes.dart';

void main() {
  AppInit.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Strings.appName,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.storeDetails,
      getPages: AppPages.routes,
    );
  }
}
