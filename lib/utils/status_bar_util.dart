import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusBarUtil {
  static systemUiOverlayStyle(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? SystemUiOverlayStyle.dark
        : SystemUiOverlayStyle.light;
  }
}
