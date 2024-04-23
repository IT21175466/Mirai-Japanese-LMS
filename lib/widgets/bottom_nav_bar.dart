import 'dart:io';
import 'package:flutter/material.dart';
import 'package:miraijapanese/constraints/app_colors.dart';
import 'package:miraijapanese/providers/bottom_nav/bottom_nav_provider.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavBarProvider>(
      builder: (BuildContext context,
          BottomNavBarProvider bottomNavigationProvider, Widget? child) {
        return Container(
          height: Platform.isIOS ? 92 : 70,
          decoration: BoxDecoration(),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: bottomNavigationProvider.currentIndex,
            onTap: (index) {
              bottomNavigationProvider.setIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.quiz,
                ),
                label: "Lessons",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.edit_document,
                ),
                label: "Past Papers",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle,
                ),
                label: "Profile",
              ),
            ],
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins',
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: 'Poppins',
            ),
            selectedItemColor: AppColors.borderColor,
            unselectedItemColor: AppColors.accentColor,
            elevation: 20.0,
            selectedIconTheme: IconThemeData(
              color: AppColors.borderColor,
            ),
          ),
        );
      },
    );
  }
}
