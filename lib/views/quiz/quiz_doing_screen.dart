import 'package:flutter/material.dart';
import 'package:miraijapanese/constraints/app_colors.dart';
import 'package:miraijapanese/widgets/answer_tile.dart';
import 'package:miraijapanese/widgets/button_widget.dart';

class QuizDoingScreen extends StatefulWidget {
  const QuizDoingScreen({super.key});

  @override
  State<QuizDoingScreen> createState() => _QuizDoingScreenState();
}

class _QuizDoingScreenState extends State<QuizDoingScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppBar().preferredSize.height,
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
                  'Question 3',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.textGrayColor,
                  ),
                ),
                Text(
                  '/25',
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
            SizedBox(
              height: 10,
            ),
            Text(
              'What is this image?',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: AppColors.textBlackColor,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: screenWidth,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.lowAccentColor,
                border: Border.all(
                  color: AppColors.textGrayColor,
                  width: 0.5,
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/samplePencil.jpg'),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            AnswerTile(
              answer: 'Laptop',
              color: Colors.red,
              textColor: Colors.white,
              borderColor: Colors.red,
              customIcon: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
            AnswerTile(
              answer: 'Mobile',
              color: Colors.white,
              textColor: AppColors.textBlackColor,
              borderColor: AppColors.borderColor,
              customIcon: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
            AnswerTile(
              answer: 'Pencil',
              color: Colors.green,
              textColor: Colors.white,
              borderColor: Colors.green,
              customIcon: Icon(
                Icons.done,
                color: Colors.white,
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: CustomButton(
                text: 'Next',
                height: 50,
                width: screenWidth / 2,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
