import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:miraijapanese/models/mark.dart';

class AppDataProvider extends ChangeNotifier {
  bool isLoading = false;

  //Student
  String firstName = '...';
  String? lastName = '...';
  String? email = '...';
  String? phoneNum = '...';
  String? dateOfBirth = '...';
  String? registedDate = '...';
  int lessionsCompleteCount = 0;
  int pastPapersCompleteCount = 0;
  List<Mark> lessionsScore = [];
  List<Mark> pastPapersScore = [];

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
      lessionsCompleteCount = studentDoc.get('Completed_Lessons');
      pastPapersCompleteCount = studentDoc.get('Completed_PastPapers');

      List<dynamic>? lessionsMarksData = studentDoc.get('Lessions_Marks');

      if (lessionsMarksData != null) {
        lessionsScore =
            lessionsMarksData.map((mark) => Mark.fromJson(mark)).toList();
      }

      List<dynamic>? pastpapersMarksData = studentDoc.get('PastPapers_Marks');

      if (pastpapersMarksData != null) {
        pastPapersScore =
            pastpapersMarksData.map((mark) => Mark.fromJson(mark)).toList();
      }

      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      Navigator.pushReplacementNamed(context, '/home');
    }
  }
}
