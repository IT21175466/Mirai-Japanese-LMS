import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:miraijapanese/constraints/app_colors.dart';
import 'package:miraijapanese/providers/authentication/auth_provider.dart';
import 'package:provider/provider.dart';

class PhoneCheckSplash extends StatefulWidget {
  final String phone;
  const PhoneCheckSplash({super.key, required this.phone});

  @override
  State<PhoneCheckSplash> createState() => _PhoneCheckSplashState();
}

class _PhoneCheckSplashState extends State<PhoneCheckSplash> {
  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.checkUserIsSignUp(widget.phone, context);
  }

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
              child: Lottie.asset('assets/animations/searching.json'),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Checking your phone number......',
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
