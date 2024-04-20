import 'package:flutter/material.dart';
import 'package:miraijapanese/providers/bottom_nav/bottom_nav_provider.dart';
import 'package:miraijapanese/routes/app_routes.dart';
import 'package:miraijapanese/views/authentication/signup_screen.dart';
import 'package:miraijapanese/views/home/home_screen.dart';
import 'package:miraijapanese/views/quiz/quiz_result_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomNavBarProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // initialRoute: '/initsplash',
        // routes: AppRoutes.getRoutes(),
        home: QuizResultsPage(),
      ),
    );
  }
}
