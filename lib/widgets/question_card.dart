import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:miraijapanese/constraints/app_colors.dart';

class QuestionCard extends StatelessWidget {
  final String quizTitle;
  final String quizAmount;
  final String image;
  final bool isLocked;
  final bool isCompleted;
  final double score;
  const QuestionCard(
      {super.key,
      required this.quizAmount,
      required this.image,
      required this.quizTitle,
      required this.isLocked,
      required this.isCompleted,
      required this.score});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          height: 70,
          width: screenWidth,
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          padding: EdgeInsets.only(left: 5, right: 10, top: 5, bottom: 5),
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.5,
              color: AppColors.borderColor.withOpacity(0.6),
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: image,
                  placeholder: (context, url) => Center(
                    child: SizedBox(
                      height: 15,
                      width: 15,
                      child: Icon(
                        Icons.image,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: Colors.red,
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
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: AppColors.textBlackColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Lesson ${quizAmount}',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: AppColors.textGrayColor,
                        ),
                      ),
                      isCompleted
                          ? Text(
                              ' | ${score}% Score',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: AppColors.textGrayColor,
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                  Spacer(),
                ],
              ),
              Spacer(),
              isLocked
                  ? SizedBox()
                  : isCompleted
                      ? SizedBox(
                          height: 25,
                          child: Image.asset('assets/icons/done.png'),
                        )
                      : SizedBox(
                          height: 15,
                          child: Image.asset('assets/icons/back.png'),
                        ),
            ],
          ),
        ),
        isLocked
            ? Container(
                height: 70,
                width: screenWidth,
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 12, 7, 7).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Spacer(),
                    isLocked
                        ? SizedBox(
                            height: 22,
                            child: Image.asset(
                              'assets/icons/lock.png',
                              color: Colors.black,
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
