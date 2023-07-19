

import 'package:advanced_course/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';

import '../presentation/resources/Theme_manager.dart';

class MyApp extends StatefulWidget {
  MyApp._internal(); 
  static final MyApp _instance =MyApp._internal();
  factory MyApp()=>_instance;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: getAppTheme(),
    debugShowCheckedModeBanner: false,
    onGenerateRoute: RouteGenerator.getRoute,initialRoute: Routes.splashRoute,);
  }
}
