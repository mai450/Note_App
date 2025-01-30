import 'package:flutter/material.dart';
import 'package:note/constants/const.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.buttonText,
      required this.onTap,
      this.isLoading = false});

  final String buttonText;
  final VoidCallback? onTap;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: kPrimaryColor,
        ),
        child: Center(
            child: isLoading
                ? CircularProgressIndicator(
                    color: Colors.black,
                  )
                : Text(
                    buttonText,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  )),
      ),
    );
  }
}
