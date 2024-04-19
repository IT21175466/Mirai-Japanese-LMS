import 'package:flutter/material.dart';
import 'package:miraijapanese/constraints/app_colors.dart';

class QuestionCard extends StatelessWidget {
  final String quizTitle;
  final String quizAmount;
  final AssetImage image;
  const QuestionCard(
      {super.key,
      required this.quizAmount,
      required this.image,
      required this.quizTitle});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 70,
      width: screenWidth,
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
          color: AppColors.borderColor,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            height: 51,
            width: 51,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: image,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              Text(
                quizTitle,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: AppColors.textBlackColor,
                ),
              ),
              Text(
                '${quizAmount} Questions',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: AppColors.textGrayColor,
                ),
              ),
              Spacer(),
            ],
          ),
          Spacer(),
          SizedBox(
            height: 20,
            child: Image.asset('assets/icons/back.png'),
          ),
        ],
      ),
    );
  }
}
