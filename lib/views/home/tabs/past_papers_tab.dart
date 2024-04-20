import 'package:flutter/material.dart';
import 'package:miraijapanese/constraints/app_colors.dart';
import 'package:miraijapanese/widgets/question_card.dart';

class PastPapersTab extends StatefulWidget {
  const PastPapersTab({super.key});

  @override
  State<PastPapersTab> createState() => _PastPapersTabState();
}

class _PastPapersTabState extends State<PastPapersTab> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Past Papers',
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
      ),
      body: Container(
        height: screenHeight - AppBar().preferredSize.height,
        width: screenWidth,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              QuestionCard(
                quizAmount: '25',
                image: AssetImage('assets/images/sporken.jpg'),
                quizTitle: 'Past Paper',
                isLocked: false,
                isCompleted: true,
                score: 82.0,
              ),
              QuestionCard(
                quizAmount: '25',
                image: AssetImage('assets/images/sporken.jpg'),
                quizTitle: 'Past Paper',
                isLocked: false,
                isCompleted: false,
                score: 0,
              ),
              QuestionCard(
                quizAmount: '25',
                image: AssetImage('assets/images/language.jpg'),
                quizTitle: 'Past Paper',
                isLocked: true,
                isCompleted: false,
                score: 0,
              ),
              QuestionCard(
                quizAmount: '25',
                image: AssetImage('assets/images/language.jpg'),
                quizTitle: 'Past Paper',
                isLocked: true,
                isCompleted: false,
                score: 0,
              ),
              QuestionCard(
                quizAmount: '25',
                image: AssetImage('assets/images/language.jpg'),
                quizTitle: 'Past Paper',
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
