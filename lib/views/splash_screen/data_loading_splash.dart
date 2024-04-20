import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:miraijapanese/constraints/app_colors.dart';

class DataLoadingSplash extends StatefulWidget {
  const DataLoadingSplash({super.key});

  @override
  State<DataLoadingSplash> createState() => _DataLoadingSplashState();
}

class _DataLoadingSplashState extends State<DataLoadingSplash> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: Column(
          children: [
            Spacer(),
            SizedBox(
              width: screenWidth / 2,
              child: Lottie.asset('assets/animations/loadingAnim.json'),
            ),
            Text(
              'Loading your data......',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: AppColors.textBlackColor,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Spacer(),
            SizedBox(
              height: 60,
              child: Image.asset('assets/images/logo.png'),
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
