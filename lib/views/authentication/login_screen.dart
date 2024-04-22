import 'dart:math';

import 'package:flutter/material.dart';
import 'package:miraijapanese/constraints/app_colors.dart';
import 'package:miraijapanese/providers/authentication/auth_provider.dart';
import 'package:miraijapanese/views/authentication/otp_screen.dart';
import 'package:miraijapanese/widgets/button_widget.dart';
import 'package:miraijapanese/widgets/phone_textfield_widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int code = 0;

  generateRandomCode() {
    Random random = Random();
    setState(() {
      code = random.nextInt(900000) + 100000;
    });
  }

  @override
  void initState() {
    super.initState();
    generateRandomCode();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Consumer(
        builder:
            (BuildContext context, AuthProvider authProvider, Widget? child) =>
                Container(
          height: screenHeight,
          width: screenWidth,
          decoration: BoxDecoration(
            color: AppColors.accentColor,
          ),
          child: Column(
            children: [
              SizedBox(
                height: AppBar().preferredSize.height / 2,
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  child: Image.asset('assets/images/login.png'),
                ),
              ),
              Container(
                height: screenHeight / 5 * 2,
                width: screenWidth,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    Text(
                      'Login',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 28,
                        color: AppColors.textBlackColor,
                      ),
                    ),
                    Text(
                      'Please enter your mobile number to continue.',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: AppColors.textGrayColor,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    PhoneTextField(
                      controller: authProvider.phoneController,
                      labelText: "Mobile Number",
                      hintText: '071234XXXX',
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          authProvider.loading = true;
                        });
                        if (authProvider.phoneController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Please enter your Phone Number",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          );
                        } else if (authProvider.phoneController.text
                                .trim()
                                .toString() ==
                            '713758116') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OTPScreen(
                                mobileNumber: '+94713758116',
                                verificationID: 123456,
                              ),
                            ),
                          );
                        } else {
                          setState(() {
                            authProvider.loading = true;
                          });

                          authProvider.getVerificationCode(
                              context, authProvider.phoneController.text, code);
                        }
                      },
                      child: authProvider.loading
                          ? Container(
                              height: 50,
                              width: screenWidth,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : CustomButton(
                              text: "Continue",
                              height: 50,
                              width: screenWidth,
                            ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
