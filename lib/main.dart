import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:miraijapanese/firebase_options.dart';
import 'package:miraijapanese/providers/bottom_nav/bottom_nav_provider.dart';
import 'package:miraijapanese/views/home/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        home: HomeScreen(),
      ),
    );
  }
}
