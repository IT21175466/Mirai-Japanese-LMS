import 'package:flutter/material.dart';
import 'package:miraijapanese/constraints/app_colors.dart';
import 'package:miraijapanese/providers/app_data/app_data_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Consumer(
      builder: (BuildContext context, AppDataProvider appDataProvider,
              Widget? child) =>
          Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi ${appDataProvider.firstName},',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: AppColors.textGrayColor,
                    ),
                  ),
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: AppColors.accentColor,
                    ),
                  ),
                ],
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
          height: screenHeight,
          width: screenWidth,
          //padding: EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Your Progress',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: AppColors.textBlackColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 75,
                  width: screenWidth,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 8,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.lowAccentColor,
                        ),
                        child: Center(
                          child: SizedBox(
                            height: 35,
                            child: Image.asset('assets/icons/avgScore.png'),
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
                            'Average Score',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: AppColors.textBlackColor,
                            ),
                          ),
                          Text(
                            'Goal 80%',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: AppColors.textGrayColor,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      Spacer(),
                      CircularPercentIndicator(
                        radius: 28.0,
                        lineWidth: 8.0,
                        percent: 0.75,
                        animation: true,
                        animationDuration: 1500,
                        center: Text(
                          "75%",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: AppColors.textGrayColor,
                          ),
                        ),
                        progressColor: AppColors.borderColor,
                        circularStrokeCap: CircularStrokeCap.round,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: screenWidth,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 8,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.lowAccentColor,
                            ),
                            child: Center(
                              child: SizedBox(
                                height: 35,
                                child:
                                    Image.asset('assets/icons/quizScore.png'),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lessons Score',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: AppColors.textBlackColor,
                                ),
                              ),
                              Text(
                                'Goal 80%',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: AppColors.textGrayColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      LinearPercentIndicator(
                        width: screenWidth - 50,
                        animation: true,
                        animationDuration: 1500,
                        lineHeight: 10.0,
                        percent: appDataProvider.completedLessions.length / 28,
                        progressColor: AppColors.borderColor,
                        barRadius: const Radius.circular(16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          '${appDataProvider.completedLessions.length} out of 28',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: AppColors.accentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: screenWidth,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 8,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.lowAccentColor,
                            ),
                            child: Center(
                              child: SizedBox(
                                height: 35,
                                child: Image.asset('assets/icons/avgScore.png'),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Past Paers Score',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: AppColors.textBlackColor,
                                ),
                              ),
                              Text(
                                'Goal 60%',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: AppColors.textGrayColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      LinearPercentIndicator(
                        width: screenWidth - 50,
                        animation: true,
                        animationDuration: 1500,
                        lineHeight: 10.0,
                        percent: 0,
                        progressColor: AppColors.borderColor,
                        barRadius: const Radius.circular(16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          '${appDataProvider.completedPastPapers.length} out of 8',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: AppColors.accentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Text(
                        'To Dos',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: AppColors.textBlackColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'See All',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: AppColors.accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
                // QuestionCard(
                //   quizAmount: '25',
                //   image: AssetImage('assets/images/sporken.jpg'),
                //   quizTitle: 'Spoken Quiz',
                //   isLocked: false,
                //   isCompleted: true,
                //   score: 82.0,
                // ),

                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
