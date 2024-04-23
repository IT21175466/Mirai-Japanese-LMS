import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:miraijapanese/constraints/app_colors.dart';
import 'package:miraijapanese/providers/app_data/app_data_provider.dart';
import 'package:provider/provider.dart';

class DataLoadingSplash extends StatefulWidget {
  final String sID;
  const DataLoadingSplash({super.key, required this.sID});

  @override
  State<DataLoadingSplash> createState() => _DataLoadingSplashState();
}

class _DataLoadingSplashState extends State<DataLoadingSplash> {
  @override
  void initState() {
    super.initState();
    final appDataProvider =
        Provider.of<AppDataProvider>(context, listen: false);
    appDataProvider.getStudentData(context, widget.sID);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: Column(
          children: [
            Spacer(),
            SizedBox(
              width: screenWidth / 2,
              child: Lottie.asset('assets/animations/loading.json'),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Loading your data......',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: AppColors.textBlackColor,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Spacer(),
            SizedBox(
              height: 50,
              child: Image.asset('assets/images/logo.png'),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
