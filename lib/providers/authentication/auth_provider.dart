import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:miraijapanese/constraints/app_colors.dart';
import 'package:miraijapanese/models/student.dart';
import 'package:miraijapanese/views/authentication/otp_screen.dart';
import 'package:miraijapanese/views/authentication/signup_screen.dart';
import 'package:miraijapanese/views/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  bool loading = false;
  bool isSucess = false;

  final db = FirebaseFirestore.instance;

  String? studentID = '';

  TextEditingController phoneController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<void> getVerificationCode(
      BuildContext context, String? phone, int? code) async {
    loading = true;
    notifyListeners();
    String Url =
        'http://send.ozonedesk.com/api/v2/send.php?user_id=105530&api_key=24bvbv0vquc2yvg8g&sender_id=My Demo sms&to=${phone}&message=Your verification code is ${code}';

    try {
      loading = true;
      notifyListeners();
      var response = await http.get(
        Uri.parse(Url),
      );
      if (response.statusCode == 200) {
        loading = false;
        isSucess = true;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Verification Code Sent',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            backgroundColor: AppColors.accentColor,
          ),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPScreen(
              mobileNumber: phoneController.text,
              verificationID: code!,
            ),
          ),
        );
      } else {
        loading = false;
        notifyListeners();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please try again later!',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      loading = false;
      notifyListeners();
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void showSuccessAlertDialog(BuildContext context, double screenWidth) {
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

  checkUserIsSignUp(String userID, BuildContext context) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      DocumentReference documentRefUsers =
          firestore.collection("Students").doc(userID);

      DocumentSnapshot docSnapshotUsers = await documentRefUsers.get();

      if (docSnapshotUsers.exists) {
        print("Student document exists");

        await setUserID(userID);
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('logedIn', true);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
        loading = false;
        notifyListeners();
      } else {
        print("Any document does not exist");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignUpScreen(
              mobile: userID,
            ),
          ),
        );
        loading = false;
        notifyListeners();
      }
    } catch (error) {
      print("Error checking document: $error");
    }
  }

  Future<void> setUserID(String uID) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userID', uID);
  }

  addStudentToFirebase(Student student, BuildContext context, String uID,
      double screenWidth) async {
    try {
      db
          .collection("Students")
          .doc(uID)
          .set(student.toJson())
          .then((value) async {
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('logedIn', true);

        showSuccessAlertDialog(context, screenWidth);

        Timer(
          Duration(seconds: 3),
          () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          ),
        );

        loading = false;
        Navigator.pushReplacementNamed(context, '/home');
        notifyListeners();
      });
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
      loading = false;
      notifyListeners();
    }
  }

  getStudentID(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    studentID = prefs.getString('userID');
    notifyListeners();
  }
}
