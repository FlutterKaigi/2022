import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.isShow,
      required this.title,
      required this.message,
      this.onPress});

  final bool isShow;
  final String title;
  final String message;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    if (!isShow) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.all(8),
      child: Tooltip(
        message: message,
        child: ElevatedButton(
          onPressed: onPress,
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.all(24),
            primary: Colors.orange,
            onPrimary: Colors.black87,
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
