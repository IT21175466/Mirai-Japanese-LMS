import 'package:flutter/material.dart';
import 'package:miraijapanese/constraints/app_colors.dart';
import 'package:miraijapanese/providers/app_data/app_data_provider.dart';
import 'package:miraijapanese/providers/quiz/question_provider.dart';
import 'package:miraijapanese/views/home/home_screen.dart';
import 'package:miraijapanese/views/quiz/single_quiz_preview.dart';
import 'package:miraijapanese/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class QuizResultsPage extends StatefulWidget {
  final int corrects;
  final int wrongs;
  final int quesionAmount;
  final double score;
  const QuizResultsPage(
      {super.key,
      required this.corrects,
      required this.wrongs,
      required this.quesionAmount,
      required this.score});

  @override
  State<QuizResultsPage> createState() => _QuizResultsPageState();
}

class _QuizResultsPageState extends State<QuizResultsPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: widget.score >= 80
            ? BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/quizResultBG.jpg'),
                  fit: BoxFit.cover,
                ),
              )
            : BoxDecoration(
                color: Colors.white,
              ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: SizedBox(
                height: 150,
                width: 150,
                child: widget.score >= 80
                    ? Image.asset('assets/images/goodJob.png')
                    : Image.asset('assets/images/fail.png'),
              ),
            ),
            Text(
              widget.score >= 80 ? 'Good Job' : 'Oh...',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 35,
                color: AppColors.accentColor,
              ),
            ),
            Text(
              widget.score >= 80
                  ? 'You passed the lesson successfully!'
                  : 'You failed the lesson. Try again!',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: AppColors.accentColor,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Your Score',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: AppColors.accentColor,
              ),
            ),
            Text(
              '${widget.score.toStringAsFixed(1)}%',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 48,
                color: AppColors.accentColor,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Spacer(),
                Container(
                  width: 100,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue,
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${widget.quesionAmount.toString()}',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Questions',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  width: 100,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.green,
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${widget.corrects.toString()}',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Correct',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  width: 100,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.red,
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${widget.wrongs.toString()}',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Incorrect',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
            Spacer(),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SingleQuizToPreview(),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  height: 50,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: AppColors.accentColor,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Preview',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        color: AppColors.accentColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Consumer2(
              builder: (BuildContext context, AppDataProvider appDataProvider,
                      QuestionProvider questionProvider, Widget? child) =>
                  GestureDetector(
                onTap: () {
                  if (mounted) {
                    questionProvider.isAnswerSelected = false;
                    questionProvider.selectedAnswer = '';
                    questionProvider.questions = [];
                    questionProvider.selectedAnswers = [];
                    questionProvider.myCorrectAnswers = 0;
                    questionProvider.myWrongAnswers = 0;
                  }

                  if (widget.score < 80.0) {
                    print('You Fail!, Try Again!');

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                        (route) => false);
                  } else {
                    setState(() {
                      appDataProvider.loading = true;
                    });
                    print('Done');

                    appDataProvider.addLessonAndSaveToFirestore(
                        widget.score.toString(), context);
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: CustomButton(
                    text: 'Done',
                    height: 50,
                    width: screenWidth,
                  ),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
