import 'package:flutter/material.dart';
import 'package:miraijapanese/views/authentication/login_screen.dart';
import 'package:miraijapanese/views/home/home_screen.dart';
import 'package:miraijapanese/views/splash_screen/initial_splash.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/initsplash': (context) => InitialSplash(),
      '/home': (context) => HomeScreen(),
      '/login': (context) => LoginScreen(),
    };
  }
}
