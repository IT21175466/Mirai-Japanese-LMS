import 'package:flutter/material.dart';
import 'package:miraijapanese/constraints/app_colors.dart';
import 'package:miraijapanese/providers/quiz/question_provider.dart';
import 'package:miraijapanese/views/quiz/quiz_result_screen.dart';
import 'package:miraijapanese/views/quiz/singleQuiz.dart';
import 'package:miraijapanese/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class QuizDoingScreen extends StatefulWidget {
  const QuizDoingScreen({super.key});

  @override
  State<QuizDoingScreen> createState() => _QuizDoingScreenState();
}

class _QuizDoingScreenState extends State<QuizDoingScreen> {
  int index = 0;

  void goToNextQuestion() {
    setState(() {
      index++;
    });
  }

  void goToPrevousQuestion() {
    setState(() {
      index--;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Consumer(
      builder: (BuildContext context, QuestionProvider questionProvider,
              Widget? child) =>
          Scaffold(
        appBar: AppBar(
          toolbarHeight: AppBar().preferredSize.height + 30,
          automaticallyImplyLeading: false,
          title: SizedBox(
            width: screenWidth,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Language Quiz I',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: AppColors.accentColor,
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      height: 20,
                      child: Image.asset('assets/icons/exit.png'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      'Question ${index + 1}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: AppColors.textGrayColor,
                      ),
                    ),
                    Text(
                      '/${questionProvider.questions.length}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        color: AppColors.textGrayColor,
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: AppColors.textGrayColor,
                ),
              ],
            ),
          ),
        ),
        body: Container(
          height: screenHeight,
          width: screenWidth,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleQuestionScreen(
                  questionNumber:
                      questionProvider.questions[index].questionNumber,
                  question: questionProvider.questions[index].question,
                  answer1: questionProvider.questions[index].answer1,
                  answer2: questionProvider.questions[index].answer2,
                  answer3: questionProvider.questions[index].answer3,
                  correctAnswer:
                      questionProvider.questions[index].correctAnswer,
                  questionImage:
                      questionProvider.questions[index].questionImage,
                  answer1Image: questionProvider.questions[index].answer1Image,
                  answer2Image: questionProvider.questions[index].answer2Image,
                  answer3Image: questionProvider.questions[index].answer3Image,
                  questionVoice:
                      questionProvider.questions[index].questionVoice,
                  answer1Voice: questionProvider.questions[index].answer1Voice,
                  answer2Voice: questionProvider.questions[index].answer2Voice,
                  answer3Voice: questionProvider.questions[index].answer3Voice,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: questionProvider.questions.length == index + 1
                        ? GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QuizResultsPage(
                                    corrects: questionProvider.myCorrectAnswers,
                                    wrongs: questionProvider.myWrongAnswers,
                                    quesionAmount:
                                        questionProvider.questions.length,
                                  ),
                                ),
                              );
                            },
                            child: CustomButton(
                              text: 'Finish',
                              height: 50,
                              width: screenWidth / 2,
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                index = index + 1;
                                questionProvider.isAnswerSelected = false;
                                questionProvider.selectedAnswer = '';
                              });
                            },
                            child: CustomButton(
                              text: 'Next',
                              height: 50,
                              width: screenWidth / 2,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
