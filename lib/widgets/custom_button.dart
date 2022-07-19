import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.isShow,
      required this.colors,
      required this.title,
      required this.message,
      this.onPress});

  final bool isShow;
  final List<MaterialColor>? colors;
  final String title;
  final String message;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    if (!isShow) return const SizedBox.shrink();

    if (colors == null) {
      return Container(
        margin: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(48.0),
          child: Container(
            margin: const EdgeInsets.all(8),
            child: Tooltip(
              message: message,
              child: ElevatedButton(
                onPressed: onPress,
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.all(28),
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
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(48.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors as List<MaterialColor>,
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
      ),
    );
  }
}
