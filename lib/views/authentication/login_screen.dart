import 'package:flutter/material.dart';
import 'package:miraijapanese/constraints/app_colors.dart';
import 'package:miraijapanese/widgets/button_widget.dart';
import 'package:miraijapanese/widgets/phone_textfield_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
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
                    controller: phoneController,
                    labelText: "Mobile Number",
                    hintText: '071234XXXX',
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                    text: "Continue",
                    height: 50,
                    width: screenWidth,
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
