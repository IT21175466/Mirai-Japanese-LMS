import 'package:flutter/material.dart';
import 'package:miraijapanese/constraints/app_colors.dart';
import 'package:miraijapanese/providers/quiz/question_provider.dart';
import 'package:miraijapanese/views/past_paper/past_paper_result_loading.dart';
import 'package:miraijapanese/views/past_paper/single_quiz_pastPaper.dart';
import 'package:miraijapanese/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class PastPaperDoingScreen extends StatefulWidget {
  final String quizName;
  const PastPaperDoingScreen({super.key, required this.quizName});

  @override
  State<PastPaperDoingScreen> createState() => _PastPaperDoingScreenState();
}

class _PastPaperDoingScreenState extends State<PastPaperDoingScreen> {
  var questionP = QuestionProvider();

  int index = 0;

  @override
  void initState() {
    super.initState();
    questionP = Provider.of<QuestionProvider>(context, listen: false);
  }

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
  void dispose() {
    super.dispose();
    questionP.isAnswerSelected = false;
    questionP.selectedAnswer = '';
    questionP.selectedAnswers = [];
    questionP.questions = [];
    questionP.myCorrectAnswers = 0;
    questionP.myWrongAnswers = 0;
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
                      widget.quizName,
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
                SingleQuestionPastPaper(
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResultLoadingPastPaper(
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
