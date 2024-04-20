import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:miraijapanese/constraints/app_colors.dart';
import 'package:miraijapanese/widgets/button_widget.dart';
import 'package:miraijapanese/widgets/phone_textfield_widget.dart';
import 'package:miraijapanese/widgets/textfiled_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    void showSuccessAlertDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: screenWidth / 2,
                    child: Lottie.asset('assets/animations/sucessAnim.json'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Successful!',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 23,
                      color: AppColors.accentColor,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'You successfully registered with\nMirai Japanese N5',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: AppColors.textGrayColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            actions: <Widget>[],
          );
        },
      );
    }

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
              child: Container(
                //width: 200,
                padding: EdgeInsets.symmetric(vertical: 25),
                child: Image.asset('assets/images/register.png'),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                //height: screenHeight / 5 * 3.5,
                width: screenWidth,
                padding: EdgeInsets.symmetric(horizontal: 20),
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
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'SignUp',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 28,
                        color: AppColors.textBlackColor,
                      ),
                    ),
                    Text(
                      'Please enter your details to continue.',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: AppColors.textGrayColor,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextField(
                      controller: firstNameController,
                      labelText: 'First Name',
                    ),
                    CustomTextField(
                      controller: lastNameController,
                      labelText: 'Last Name',
                    ),
                    PhoneTextField(
                      controller: phoneController,
                      labelText: "Mobile Number",
                      hintText: '071234XXXX',
                    ),
                    CustomTextField(
                      controller: emailController,
                      labelText: 'Email',
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 7),
                      height: 50,
                      child: TextField(
                        readOnly: true,
                        controller: dateOfBirthController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: const BorderSide(
                              color: AppColors.borderColor,
                              width: 0.5,
                            ),
                          ),
                          suffixIcon: GestureDetector(
                            // onTap: () {
                            //   signUPProvider.selectBirthDay(context);
                            // },
                            child: Icon(Icons.calendar_month,
                                color: AppColors.textGrayColor),
                          ),
                          labelText: "Date of birth",
                          labelStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.textGrayColor,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        showSuccessAlertDialog();
                      },
                      child: CustomButton(
                        text: "Continue",
                        height: 50,
                        width: screenWidth,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
