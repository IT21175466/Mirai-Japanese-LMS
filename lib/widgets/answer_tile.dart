import 'package:flutter/material.dart';

class AnswerTile extends StatefulWidget {
  final String answer;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final Icon customIcon;
  const AnswerTile({
    super.key,
    required this.answer,
    required this.color,
    required this.textColor,
    required this.borderColor,
    required this.customIcon,
  });

  @override
  State<AnswerTile> createState() => _AnswerTileState();
}

class _AnswerTileState extends State<AnswerTile> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.color,
        border: Border.all(
          color: widget.borderColor,
        ),
      ),
      child: Row(
        children: [
          Text(
            widget.answer,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: widget.textColor,
            ),
          ),
          Spacer(),
          widget.customIcon,
        ],
      ),
    );
  }
}
