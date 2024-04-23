import 'dart:io';

import 'package:flutter/material.dart';
import 'package:miraijapanese/constraints/app_colors.dart';
import 'package:miraijapanese/providers/app_data/app_data_provider.dart';
import 'package:miraijapanese/widgets/user_info_card.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text(
              'Profile',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            Spacer(),
            SizedBox(
              width: 45,
              child: Image.asset('assets/images/splashLogo.png'),
            ),
          ],
        ),
        backgroundColor: AppColors.accentColor,
      ),
      body: Consumer(
        builder: (BuildContext context, AppDataProvider appDataProvider,
                Widget? child) =>
            Container(
          height: screenHeight,
          width: screenWidth,
          decoration: BoxDecoration(
            color: AppColors.accentColor,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: AppBar().preferredSize.height / 2,
                ),
                Container(
                  width: screenWidth,
                  height: screenHeight - (Platform.isIOS ? 92 : 70),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                image: AssetImage('assets/images/profile.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${appDataProvider.firstName} ${appDataProvider.lastName}',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: AppColors.textBlackColor,
                                ),
                              ),
                              Text(
                                '${appDataProvider.phoneNum}',
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
                        height: 10,
                      ),
                      Container(
                        width: screenWidth,
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                                      child: Image.asset(
                                        'assets/icons/progress.png',
                                      ),
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
                                      'Progress',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: AppColors.textBlackColor,
                                      ),
                                    ),
                                    Text(
                                      'Goal 100%',
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
                              percent: appDataProvider.lessionsCompleteCount +
                                  appDataProvider.pastPapersCompleteCount / 1,
                              // (appDataProvider.lessionsScore.length +
                              //     appDataProvider
                              //         .pastPapersScore.length), // Remove + 1
                              progressColor: AppColors.borderColor,
                              barRadius: const Radius.circular(16),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Container(
                            width: screenWidth / 2 - 30,
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
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
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: 35,
                                  child: Image.asset(
                                    'assets/icons/quizScore.png',
                                    color: AppColors.accentColor,
                                  ),
                                ),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      appDataProvider.lessionsCompleteCount
                                          .toString(),
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 36,
                                        color: AppColors.accentColor,
                                      ),
                                    ),
                                    Text(
                                      'Lessons\nCompleted',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11,
                                        color: AppColors.textGrayColor,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: screenWidth / 2 - 30,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
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
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: 35,
                                  child: Image.asset(
                                    'assets/icons/paste.png',
                                    color: AppColors.accentColor,
                                  ),
                                ),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      appDataProvider.pastPapersCompleteCount
                                          .toString(),
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 36,
                                        color: AppColors.accentColor,
                                      ),
                                    ),
                                    Text(
                                      'Past Papers\nCompleted',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11,
                                        color: AppColors.textGrayColor,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'Personal Details',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: AppColors.textBlackColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      UserInfoCard(
                        phone: '${appDataProvider.phoneNum}',
                        info: 'Phone Number',
                        image: Image.asset('assets/icons/phoneNumber.png'),
                      ),
                      appDataProvider.email.toString().isEmpty
                          ? SizedBox()
                          : UserInfoCard(
                              phone: '${appDataProvider.email}',
                              info: 'Email',
                              image: Image.asset('assets/icons/email.png'),
                            ),
                      UserInfoCard(
                        phone: '${appDataProvider.registedDate}',
                        info: 'Registerd in',
                        image: Image.asset('assets/icons/registerdIn.png'),
                      ),
                    ],
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
