import 'package:flutter/material.dart';
import 'package:miraijapanese/views/splash_screen/initial_splash.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/initsplash': (context) => InitialSplash(),
    };
  }
}
