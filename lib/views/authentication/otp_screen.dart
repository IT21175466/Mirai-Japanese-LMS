import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miraijapanese/constraints/app_colors.dart';
import 'package:miraijapanese/providers/authentication/auth_provider.dart';
import 'package:miraijapanese/views/splash_screen/phone_check_splash.dart';
import 'package:miraijapanese/widgets/button_widget.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatefulWidget {
  final String mobileNumber;
  final int verificationID;
  const OTPScreen(
      {super.key, required this.mobileNumber, required this.verificationID});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController otpController = TextEditingController();

  String uuid = '';
  String? stdID = '';

  bool loading = false;

  @override
  void initState() {
    super.initState();
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Phone Verification',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.accentColor,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: screenWidth,
        height: screenHeight,
        child: Consumer(
          builder: (BuildContext context, AuthProvider authProvider,
                  Widget? child) =>
              Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "We have send an OTP to your number",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.mobileNumber,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Pinput(
                controller: otpController,
                length: 6,
                defaultPinTheme: PinTheme(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.borderColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  if (otpController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please enter OTP"),
                      ),
                    );
                  } else {
                    if (otpController.text ==
                        widget.verificationID.toString()) {
                      try {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PhoneCheckSplash(phone: widget.mobileNumber),
                          ),
                        );
                      } catch (e) {
                        print(e);
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Verification Failed!',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      setState(() {
                        loading = false;
                      });
                    }
                  }
                },
                child: loading
                    ? Container(
                        height: 50,
                        width: screenWidth,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : CustomButton(
                        text: 'Verify',
                        height: 50,
                        width: screenWidth,
                      ),
              ),
              Spacer(),
              Spacer(),
              Spacer(),
              SizedBox(
                height: 60,
                child: Image.asset('assets/images/logo.png'),
              ),
              SizedBox(
                height: Platform.isIOS ? 60 : 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
