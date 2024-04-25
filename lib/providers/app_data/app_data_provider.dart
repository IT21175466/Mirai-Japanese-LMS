import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDataProvider extends ChangeNotifier {
  bool isLoading = false;

  String? studentID = '';

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

  Future<void> getData() async {
    await getStudentID();

    try {
      final documentSnapshot = await FirebaseFirestore.instance
          .collection("Students")
          .doc(studentID)
          .get();

      if (documentSnapshot.exists) {
        final List<dynamic> lessonsData =
            documentSnapshot.data()!['Completed_Lessons'];

        // Clear existing data in completedLessons list
        completedLessions.clear();

        // Iterate through lessonsData and add them to completedLessons
        for (dynamic lessonData in lessonsData) {
          completedLessions.add(lessonData
              .toString()); // Assuming lessonData is a String or can be converted to String
          print(lessonData.toString());
        }

        notifyListeners();
        print('Data fetched successfully.');
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> addLessonAndSaveToFirestore(String newLessonScore) async {
    await getStudentID();
    // Update the local list
    completedLessions.add(newLessonScore);

    // Update Firestore document
    try {
      await FirebaseFirestore.instance
          .collection('Students') // Change 'users' to your collection
          .doc(studentID)
          .update({
        'Completed_Lessons': completedLessions,
      });
      print('Lesson added and updated in Firestore successfully.');
    } catch (e) {
      print('Error updating Firestore: $e');
    } finally {
      completedLessions = [];
      notifyListeners();
    }
  }

  getStudentID() async {
    final prefs = await SharedPreferences.getInstance();

    studentID = prefs.getString('userID');
    notifyListeners();
  }
}
