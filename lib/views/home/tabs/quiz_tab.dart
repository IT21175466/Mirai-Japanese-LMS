import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot lesson = snapshot.data!.docs[index];
                      return GestureDetector(
                        onTap: () {
                          if (appDataProvider.completedLessions
                              .contains(lesson['LessonNo'])) {
                            print('Quiz Did!');
                          } else {
                            if (appDataProvider.completedLessions.contains(
                                    int.parse(lesson['LessonNo'].toString()) -
                                        1) ||
                                lesson['LessonNo'] == '2') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QuizLoadingScreen(
                                    quizNo: lesson['LessonNo'],
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
                          image: NetworkImage(lesson['Image_Url']),
                          quizTitle: lesson['LessonTitle'],
                          isLocked: appDataProvider.completedLessions.contains(
                                  int.parse(lesson['LessonNo'].toString()) - 1)
                              ? false
                              : lesson['LessonNo'] == '1'
                                  ? false
                                  : true,
                          isCompleted: appDataProvider.completedLessions
                              .contains(lesson['LessonNo']),
                          score: 82.0,
                        ),
                      );
                    });
              }
            },
          ),
        ),
      ),
    );
  }
}
