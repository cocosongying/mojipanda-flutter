import 'package:flutter/material.dart';
import 'package:mojipanda/widgets/activity_indicator.dart';

class AppBarIndicator extends StatelessWidget {
  final double radius;

  AppBarIndicator({this.radius});

  @override
  Widget build(BuildContext context) {
    return ActivityIndicator(
      brightness: Brightness.dark,
      radius: radius,
    );
  }
}
