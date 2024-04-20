import 'package:flutter/material.dart';
import 'package:miraijapanese/constraints/app_colors.dart';
import 'package:miraijapanese/widgets/question_card.dart';
import 'package:miraijapanese/widgets/search_textfeild.dart';

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
        toolbarHeight: 130,
        title: Column(
          children: [
            Row(
              children: [
                Text(
                  'Quizzes',
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
            SizedBox(
              height: 10,
            ),
            SearchTextField(
              controller: searchController,
              labelText: 'Search',
            ),
          ],
        ),
      ),
      body: Container(
        height: screenHeight - 130,
        width: screenWidth,
        child: SingleChildScrollView(
          child: Column(
            children: [
              QuestionCard(
                quizAmount: '25',
                image: AssetImage('assets/images/sporken.jpg'),
                quizTitle: 'Spoken Quiz',
                isLocked: false,
                isCompleted: true,
                score: 82.0,
              ),
              QuestionCard(
                quizAmount: '25',
                image: AssetImage('assets/images/sporken.jpg'),
                quizTitle: 'Spoken Quiz II',
                isLocked: false,
                isCompleted: false,
                score: 0,
              ),
              QuestionCard(
                quizAmount: '25',
                image: AssetImage('assets/images/language.jpg'),
                quizTitle: 'Language Quiz I',
                isLocked: true,
                isCompleted: false,
                score: 0,
              ),
              QuestionCard(
                quizAmount: '25',
                image: AssetImage('assets/images/language.jpg'),
                quizTitle: 'Language Quiz I',
                isLocked: true,
                isCompleted: false,
                score: 0,
              ),
              QuestionCard(
                quizAmount: '25',
                image: AssetImage('assets/images/language.jpg'),
                quizTitle: 'Language Quiz I',
                isLocked: true,
                isCompleted: false,
                score: 0,
              ),
              QuestionCard(
                quizAmount: '25',
                image: AssetImage('assets/images/language.jpg'),
                quizTitle: 'Language Quiz I',
                isLocked: true,
                isCompleted: false,
                score: 0,
              ),
              QuestionCard(
                quizAmount: '25',
                image: AssetImage('assets/images/language.jpg'),
                quizTitle: 'Language Quiz I',
                isLocked: true,
                isCompleted: false,
                score: 0,
              ),
              QuestionCard(
                quizAmount: '25',
                image: AssetImage('assets/images/language.jpg'),
                quizTitle: 'Language Quiz I',
                isLocked: true,
                isCompleted: false,
                score: 0,
              ),
              QuestionCard(
                quizAmount: '25',
                image: AssetImage('assets/images/language.jpg'),
                quizTitle: 'Language Quiz I',
                isLocked: true,
                isCompleted: false,
                score: 0,
              ),
              QuestionCard(
                quizAmount: '25',
                image: AssetImage('assets/images/language.jpg'),
                quizTitle: 'Language Quiz I',
                isLocked: true,
                isCompleted: false,
                score: 0,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
