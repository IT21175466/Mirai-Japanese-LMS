import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:miraijapanese/views/splash_screen/data_loading_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDataProvider extends ChangeNotifier {
  bool isLoading = false;

  String? studentID = '';
  bool loading = false;

  int lessonsAmount = 0;
  int pastPapersAmount = 0;

  double lessonsScore = 0.0;
  double pastPaspersScore = 0.0;

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
      // completedLessions = studentDoc.get('Completed_Lessons');
      // completedPastPapers = studentDoc.get('Completed_PastPapers');

      await getData();
      await getAndCountLessonsAndPapersAmount();
      getScores();

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

      final documentSnapshotPastPapers = await FirebaseFirestore.instance
          .collection("Students")
          .doc(studentID)
          .get();

      if (documentSnapshotPastPapers.exists) {
        final List<dynamic> pastPaperData =
            documentSnapshotPastPapers.data()!['Completed_PastPapers'];

        // Clear existing data in completedLessons list
        completedPastPapers.clear();

        // Iterate through lessonsData and add them to completedLessons
        for (dynamic pastPaperData in pastPaperData) {
          completedPastPapers.add(pastPaperData
              .toString()); // Assuming lessonData is a String or can be converted to String
          print(pastPaperData.toString());
        }

        notifyListeners();
        print('Past Papers fetched successfully.');
      } else {
        print('Document does not exist');
      }

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
        print('Lessons fetched successfully.');
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> addLessonAndSaveToFirestore(
      String newLessonScore, BuildContext context) async {
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
      loading = false;
      notifyListeners();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => DataLoadingSplash(sID: studentID!)),
          (route) => false);
    }
  }

  Future<void> addPastPaperAndSaveToFirestore(
      String newLessonScore, BuildContext context) async {
    await getStudentID();
    // Update the local list
    completedPastPapers.add(newLessonScore);

    // Update Firestore document
    try {
      await FirebaseFirestore.instance
          .collection('Students') // Change 'users' to your collection
          .doc(studentID)
          .update({
        'Completed_PastPapers': completedPastPapers,
      });
      print('Past Paper added and updated in Firestore successfully.');
    } catch (e) {
      print('Error updating Firestore: $e');
    } finally {
      completedPastPapers = [];
      loading = false;
      notifyListeners();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => DataLoadingSplash(sID: studentID!)),
          (route) => false);
    }
  }

  getStudentID() async {
    final prefs = await SharedPreferences.getInstance();

    studentID = prefs.getString('userID');
    notifyListeners();
  }

  getAndCountLessonsAndPapersAmount() async {
    final QuerySnapshot qSnapLessons =
        await FirebaseFirestore.instance.collection('Lessons').get();
    lessonsAmount = qSnapLessons.docs.length;
    notifyListeners();

    final QuerySnapshot qSnapPastPapers =
        await FirebaseFirestore.instance.collection('PastPapers').get();
    pastPapersAmount = qSnapPastPapers.docs.length;
    notifyListeners();
  }

  getScores() {
    lessonsScore = 0.0;
    pastPaspersScore = 0.0;

    for (int i = 0; i < completedLessions.length; i++) {
      lessonsScore = lessonsScore + double.parse(completedLessions[i]);

      notifyListeners();
    }
    print('Lessons Score: $lessonsScore');

    for (int i = 0; i < completedPastPapers.length; i++) {
      pastPaspersScore =
          pastPaspersScore + double.parse(completedPastPapers[i]);
      notifyListeners();
    }
    print('Past Papers Score: $pastPaspersScore');
  }
}
