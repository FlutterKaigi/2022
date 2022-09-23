import 'package:flutter/cupertino.dart';

Future<void> animationScroll(Object anchor) async {
  final context = GlobalObjectKey(anchor).currentContext;
  if (context == null) {
    throw ErrorDescription(
        "An unregistered object was passed in animationScroll.\nYou should register GlobalObjectKey for some widget.");
  }
  await Scrollable.ensureVisible(context,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastOutSlowIn);
}
