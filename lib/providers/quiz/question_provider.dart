import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:miraijapanese/models/question.dart';
import 'package:miraijapanese/views/past_paper/past_paper_doing_screen.dart';
import 'package:miraijapanese/views/quiz/quiz_doing_screen.dart';

class QuestionProvider extends ChangeNotifier {
  bool gettingQuestions = false;
  List<Question> questions = [];

  List<String> selectedAnswers = [];

  //
  String questionNumber = '';
  String questionA = '';
  String answer1 = '';
  String answer2 = '';
  String answer3 = '';
  String correctAnswer = '';
  //Images
  String questionImage = '';
  String answer1Image = '';
  String answer2Image = '';
  String answer3Image = '';
  //Voice
  String questionVoice = '';
  String answer1Voice = '';
  String answer2Voice = '';
  String answer3Voice = '';

  //Question
  int myCorrectAnswers = 0;
  int myWrongAnswers = 0;

  bool answerIsCorrect = false;
  bool isAnswerSelected = false;

  String selectedAnswer = '';

  checkAnswerCorrectOrNot(String defaultCorrectAnswer, String selectedAnswer) {
    if (defaultCorrectAnswer == selectedAnswer) {
      answerIsCorrect = true;
      myCorrectAnswers = myCorrectAnswers + 1;
      print("Answer is correct");
      notifyListeners();
    } else {
      answerIsCorrect = false;
      print("Answer is wrong");
      myWrongAnswers = myWrongAnswers + 1;
      notifyListeners();
    }
  }

  Future<void> getQuestions(String lessonNo, BuildContext context) async {
    gettingQuestions = true;
    questions.clear();
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("Lessons")
          .doc(lessonNo)
          .collection("Questions")
          .get();

      for (QueryDocumentSnapshot quizDoc in querySnapshot.docs) {
        //Map<String, dynamic> data = quizDoc.data() as Map<String, dynamic>;

        questionNumber = quizDoc['QuestionNo'];
        questionA = quizDoc['Question'];
        answer1 = quizDoc['Answer1'];
        answer2 = quizDoc['Answer2'];
        answer3 = quizDoc['Answer3'];
        correctAnswer = quizDoc['CorrectAnswer'];
        //Images
        questionImage = quizDoc['Question_Image'];
        answer1Image = quizDoc['Answer1_Image'];
        answer2Image = quizDoc['Answer2_Image'];
        answer3Image = quizDoc['Answer2_Image'];
        //Voice
        questionVoice = quizDoc['Question_Voice'];
        answer1Voice = quizDoc['Answer1_Voice'];
        answer2Voice = quizDoc['Answer2_Voice'];
        answer3Voice = quizDoc['Answer3_Voice'];

        Question question = Question(
            questionNumber: questionNumber,
            question: questionA,
            answer1: answer1,
            answer2: answer2,
            answer3: answer3,
            correctAnswer: correctAnswer,
            questionImage: questionImage,
            answer1Image: answer1Image,
            answer2Image: answer2Image,
            answer3Image: answer3Image,
            questionVoice: questionVoice,
            answer1Voice: answer1Voice,
            answer2Voice: answer2Voice,
            answer3Voice: answer3Voice);
        questions.add(question);
        print(question);

        notifyListeners();
      }
    } catch (error) {
      print("Error getting questions: $error");
    } finally {
      gettingQuestions = false;
      Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => QuizDoingScreen(),
          ),
        ),
      );
    }
  }

  Future<void> getPastPapers(String lessonNo, BuildContext context) async {
    gettingQuestions = true;
    questions.clear();
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("PastPapers")
          .doc(lessonNo)
          .collection("Questions")
          .get();

      for (QueryDocumentSnapshot quizDoc in querySnapshot.docs) {
        //Map<String, dynamic> data = quizDoc.data() as Map<String, dynamic>;

        questionNumber = quizDoc['QuestionNo'];
        questionA = quizDoc['Question'];
        answer1 = quizDoc['Answer1'];
        answer2 = quizDoc['Answer2'];
        answer3 = quizDoc['Answer3'];
        correctAnswer = quizDoc['CorrectAnswer'];
        //Images
        questionImage = quizDoc['Question_Image'];
        answer1Image = quizDoc['Answer1_Image'];
        answer2Image = quizDoc['Answer2_Image'];
        answer3Image = quizDoc['Answer2_Image'];
        //Voice
        questionVoice = quizDoc['Question_Voice'];
        answer1Voice = quizDoc['Answer1_Voice'];
        answer2Voice = quizDoc['Answer2_Voice'];
        answer3Voice = quizDoc['Answer3_Voice'];

        Question question = Question(
            questionNumber: questionNumber,
            question: questionA,
            answer1: answer1,
            answer2: answer2,
            answer3: answer3,
            correctAnswer: correctAnswer,
            questionImage: questionImage,
            answer1Image: answer1Image,
            answer2Image: answer2Image,
            answer3Image: answer3Image,
            questionVoice: questionVoice,
            answer1Voice: answer1Voice,
            answer2Voice: answer2Voice,
            answer3Voice: answer3Voice);
        questions.add(question);
        print(question);

        notifyListeners();
      }
    } catch (error) {
      print("Error getting questions: $error");
    } finally {
      gettingQuestions = false;
      Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PastPaperDoingScreen(),
          ),
        ),
      );
    }
  }
}
