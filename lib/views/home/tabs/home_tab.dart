import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:miraijapanese/constraints/app_colors.dart';
import 'package:miraijapanese/providers/app_data/app_data_provider.dart';
import 'package:miraijapanese/providers/quiz/question_provider.dart';
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
    return Consumer2(
      builder: (BuildContext context, QuestionProvider questionProvider,
              AppDataProvider appDataProvider, Widget? child) =>
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
                            'Quiz Complete Rate',
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
                        percent: appDataProvider.completedLessions.length ==
                                    0 ||
                                appDataProvider.completedPastPapers.length == 0
                            ? 0
                            : (appDataProvider.completedLessions.length +
                                    appDataProvider.completedPastPapers.length /
                                        appDataProvider.lessonsAmount +
                                    appDataProvider.pastPapersAmount) /
                                100,
                        animation: true,
                        animationDuration: 1500,
                        center: Text(
                          "${appDataProvider.completedLessions.length == 0 || appDataProvider.completedPastPapers.length == 0 ? 0 : ((appDataProvider.completedLessions.length + appDataProvider.completedPastPapers.length / appDataProvider.lessonsAmount + appDataProvider.pastPapersAmount) / 100).toStringAsFixed(2)}",
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
                        percent: appDataProvider.completedLessions.length == 0
                            ? 0
                            : (appDataProvider.lessonsScore /
                                    appDataProvider.completedLessions.length) /
                                100,
                        progressColor: AppColors.borderColor,
                        barRadius: const Radius.circular(16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          '${appDataProvider.completedLessions.length} out of ${appDataProvider.lessonsAmount}',
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
                                'Past Papers Score',
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
                        percent: appDataProvider.completedPastPapers.length == 0
                            ? 0
                            : (appDataProvider.pastPaspersScore /
                                    appDataProvider
                                        .completedPastPapers.length) /
                                100,
                        progressColor: AppColors.borderColor,
                        barRadius: const Radius.circular(16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          '${appDataProvider.completedPastPapers.length} out of ${appDataProvider.pastPapersAmount}',
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
                appDataProvider.completedLessions.length ==
                        appDataProvider.lessonsAmount
                    ? SizedBox()
                    : Container(
                        width: screenWidth,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('Lessons')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData) {
                              return Text('No data available');
                            } else {
                              return Stack(
                                children: [
                                  Container(
                                    height: 70,
                                    width: screenWidth,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 15),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
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
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            image: DecorationImage(
                                              image: NetworkImage(snapshot
                                                      .data!.docs[
                                                  appDataProvider
                                                      .completedLessions
                                                      .length]['Image_Url']),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Spacer(),
                                            Text(
                                              snapshot.data!.docs[
                                                  appDataProvider
                                                      .completedLessions
                                                      .length]['LessonTitle'],
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                                color: AppColors.textBlackColor,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Lesson ${snapshot.data!.docs[appDataProvider.completedLessions.length]['LessonNo']}',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13,
                                                    color:
                                                        AppColors.textGrayColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                appDataProvider.completedPastPapers.length ==
                        appDataProvider.pastPapersAmount
                    ? SizedBox()
                    : Container(
                        width: screenWidth,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('PastPapers')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData) {
                              return Text('No data available');
                            } else {
                              return Stack(
                                children: [
                                  Container(
                                    height: 70,
                                    width: screenWidth,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 15),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
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
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            image: DecorationImage(
                                              image: NetworkImage(snapshot
                                                      .data!.docs[
                                                  appDataProvider
                                                      .completedPastPapers
                                                      .length]['Image_Url']),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Spacer(),
                                            Text(
                                              snapshot.data!.docs[
                                                  appDataProvider
                                                      .completedPastPapers
                                                      .length]['LessonTitle'],
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                                color: AppColors.textBlackColor,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Lesson ${snapshot.data!.docs[appDataProvider.completedPastPapers.length]['LessonNo']}',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13,
                                                    color:
                                                        AppColors.textGrayColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),
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
