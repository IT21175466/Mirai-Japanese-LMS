import 'package:flutter/material.dart';
import 'package:miraijapanese/constraints/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7),
      height: 50,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: AppColors.borderColor,
              width: 0.5,
            ),
          ),
          labelText: labelText,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        ),
      ),
    );
  }
}
