import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:miraijapanese/constraints/app_colors.dart';
import 'package:miraijapanese/providers/quiz/question_provider.dart';
import 'package:provider/provider.dart';

class PastPaperLoadingScreen extends StatefulWidget {
  final String quizNo;
  const PastPaperLoadingScreen({super.key, required this.quizNo});

  @override
  State<PastPaperLoadingScreen> createState() => _PastPaperLoadingScreenState();
}

class _PastPaperLoadingScreenState extends State<PastPaperLoadingScreen> {
  @override
  void initState() {
    super.initState();
    final quizProvider = Provider.of<QuestionProvider>(context, listen: false);
    quizProvider.getPastPapers(widget.quizNo, context);
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
              child: Lottie.asset('assets/animations/lessonLoading.json'),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Preparing your past paper......',
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
