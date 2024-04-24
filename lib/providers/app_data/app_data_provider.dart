import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppDataProvider extends ChangeNotifier {
  bool isLoading = false;

  //Student
  String firstName = '...';
  String? lastName = '...';
  String? email = '...';
  String? phoneNum = '...';
  String? dateOfBirth = '...';
  String? registedDate = '...';
  List<String> completedLessions = [];
  List<String> completedPastPapers = [];

  getStudentData(BuildContext context, String sID) async {
    try {
      final DocumentSnapshot studentDoc = await FirebaseFirestore.instance
          .collection("Students")
          .doc(sID)
          .get();

      firstName = studentDoc.get('FirstName');
      lastName = studentDoc.get('LastName');
      email = studentDoc.get('Email');
      phoneNum = studentDoc.get('PhoneNumber');
      dateOfBirth = studentDoc.get('DateOfBirth');
      registedDate = studentDoc.get('Registed_Date');
      completedLessions = studentDoc.get('Completed_Lessons');
      completedPastPapers = studentDoc.get('Completed_PastPapers');

      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      Navigator.pushReplacementNamed(context, '/home');
    }
  }
}
