import 'package:flutter/material.dart';
import 'package:mojipanda/routers/routers.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {

  @override
  MainApp() {
    FluroRouter.initRouter();
  }
  @override
  _MainAppState createState() => _MainAppState();

}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: FluroRouter.router.generator
    );
  }
}