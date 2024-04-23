import 'dart:async';

import 'package:flutter/material.dart';
import 'package:miraijapanese/constraints/app_colors.dart';
import 'package:miraijapanese/views/splash_screen/data_loading_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeSplash extends StatefulWidget {
  const HomeSplash({super.key});

  @override
  State<HomeSplash> createState() => _HomeSplashState();
}

class _HomeSplashState extends State<HomeSplash> {
  String? studentID = '';

  @override
  void initState() {
    super.initState();
    getStudentID(context);
  }

  getStudentID(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      studentID = prefs.getString('userID');
    });

    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DataLoadingSplash(
            sID: studentID!,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 0.6,
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Spacer(),
            SizedBox(
              height: 170,
              child: Image.asset('assets/images/splashLogo.png'),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Mirai Japanese N5',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 26,
                color: AppColors.textBlackColor,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Spacer(),
            Text(
              'Powered by Appexis',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColors.textBlackColor,
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
