import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:miraijapanese/constraints/app_colors.dart';
import 'package:miraijapanese/providers/app_data/app_data_provider.dart';
import 'package:miraijapanese/providers/quiz/question_provider.dart';
import 'package:miraijapanese/views/quiz/quiz_result_screen.dart';
import 'package:provider/provider.dart';

class ResultsLoadingScreen extends StatefulWidget {
  final int corrects;
  final int wrongs;
  final int quesionAmount;
  const ResultsLoadingScreen(
      {super.key,
      required this.corrects,
      required this.wrongs,
      required this.quesionAmount});

  @override
  State<ResultsLoadingScreen> createState() => _ResultsLoadingScreenState();
}

class _ResultsLoadingScreenState extends State<ResultsLoadingScreen> {
  double score = 0.0;
  @override
  void initState() {
    super.initState();
    score = (widget.corrects / widget.quesionAmount) * 100;
    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);
    questionProvider.isAnswerSelected = false;
    questionProvider.selectedAnswer = '';
    final appDataProvider =
        Provider.of<AppDataProvider>(context, listen: false);
    appDataProvider.getData().then((value) => {
          Timer(
            Duration(seconds: 2),
            () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => QuizResultsPage(
                  corrects: widget.corrects,
                  wrongs: widget.wrongs,
                  quesionAmount: widget.quesionAmount,
                  score: score,
                ),
              ),
            ),
          ),
        });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: Column(
          children: [
            Spacer(),
            SizedBox(
              width: screenWidth / 2,
              child: Lottie.asset('assets/animations/results.json'),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Let's see your result......",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: AppColors.textBlackColor,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Spacer(),
            SizedBox(
              height: 50,
              child: Image.asset('assets/images/logo.png'),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
