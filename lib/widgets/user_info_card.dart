import 'package:flutter/material.dart';
import 'package:miraijapanese/constraints/app_colors.dart';

class UserInfoCard extends StatelessWidget {
  final String phone;
  final String info;
  final Image image;
  const UserInfoCard(
      {super.key,
      required this.phone,
      required this.info,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        children: [
          SizedBox(
            height: 20,
            child: image,
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                info,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: AppColors.textGrayColor,
                ),
              ),
              Text(
                phone,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppColors.textBlackColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
