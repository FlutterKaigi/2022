import 'package:flutter/material.dart';

class CustomNoticeButton extends StatelessWidget {
  const CustomNoticeButton(
      {super.key,
      required this.isShow,
      required this.title,
      required this.message,
      required this.onPress});

  final bool isShow;
  final String title;
  final String message;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    if (!isShow) return const SizedBox.shrink();

    return ClipRRect(
      borderRadius: BorderRadius.circular(48.0),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.green],
          ),
        ),
        child: Tooltip(
          message: message,
          child: TextButton(
            onPressed: onPress,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
