import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:miraijapanese/constraints/app_colors.dart';
import 'package:miraijapanese/providers/app_data/app_data_provider.dart';
import 'package:miraijapanese/views/quiz/quiz_lo0ading_screen.dart';
import 'package:miraijapanese/widgets/question_card.dart';
import 'package:provider/provider.dart';

class QuizTab extends StatefulWidget {
  const QuizTab({super.key});

  @override
  State<QuizTab> createState() => _QuizTabState();
}

class _QuizTabState extends State<QuizTab> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //toolbarHeight: 130,
        title: Column(
          children: [
            Row(
              children: [
                Text(
                  'Lessons',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: AppColors.accentColor,
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: 45,
                  child: Image.asset('assets/images/splashLogo.png'),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Consumer(
        builder: (BuildContext context, AppDataProvider appDataProvider,
                Widget? child) =>
            Container(
          height: screenHeight - 130,
          width: screenWidth,
          padding: EdgeInsets.only(top: 20),
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('Lessons').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return Text('No data available');
              } else {
                return AnimationLimiter(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot lesson = snapshot.data!.docs[index];
                        return AnimationConfiguration.staggeredList(
                          duration: const Duration(milliseconds: 375),
                          position: index,
                          child: SlideAnimation(
                            verticalOffset: 200.0,
                            child: FadeInAnimation(
                              child: GestureDetector(
                                onTap: () {
                                  if (appDataProvider
                                          .completedLessions.length >=
                                      int.parse(lesson['LessonNo'])) {
                                    print('Quiz Did!');
                                  } else {
                                    if (appDataProvider
                                                .completedLessions.length ==
                                            int.parse(lesson['LessonNo']) - 1 ||
                                        lesson['LessonNo'] == '1') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              QuizLoadingScreen(
                                            quizNo: lesson['LessonNo'],
                                            lessonTitle: lesson['LessonTitle'],
                                          ),
                                        ),
                                      );
                                    } else {
                                      print('Locked!');
                                    }
                                  }
                                },
                                child: QuestionCard(
                                  quizAmount: lesson['LessonNo'],
                                  image: lesson['Image_Url'],
                                  quizTitle: lesson['LessonTitle'],
                                  isLocked:
                                      appDataProvider.completedLessions.length +
                                                  1 >=
                                              int.parse(
                                                  lesson['LessonNo'].toString())
                                          ? false
                                          : lesson['LessonNo'] == '1'
                                              ? false
                                              : true,
                                  isCompleted: appDataProvider
                                              .completedLessions.length >=
                                          int.parse(
                                              lesson['LessonNo'].toString())
                                      ? true
                                      : false,
                                  score: appDataProvider
                                              .completedLessions.length >=
                                          int.parse(
                                              lesson['LessonNo'].toString())
                                      ? double.parse(appDataProvider
                                              .completedLessions[
                                          int.parse(lesson['LessonNo']) - 1])
                                      : 0.0,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
