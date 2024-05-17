import 'package:flutter/material.dart';
import 'package:miraijapanese/providers/bottom_nav/bottom_nav_provider.dart';
import 'package:miraijapanese/views/home/tabs/home_tab.dart';
import 'package:miraijapanese/views/home/tabs/past_papers_tab.dart';
import 'package:miraijapanese/views/home/tabs/profile_tab.dart';
import 'package:miraijapanese/views/home/tabs/quiz_tab.dart';
import 'package:miraijapanese/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (BuildContext context,
                BottomNavBarProvider bottomNavigationProvider, Widget? child) =>
            IndexedStack(
          index: bottomNavigationProvider.currentIndex,
          children: [
            HomeTab(),
            QuizTab(),
            PastPapersTab(),
            ProfileTab(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
