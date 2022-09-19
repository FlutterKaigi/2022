import 'package:flutter/cupertino.dart';

Future<void> animationScroll(Object anchor) async {
  final context = GlobalObjectKey(anchor).currentContext;
  if (context == null) {
    throw Error();
  }
  await Scrollable.ensureVisible(context,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastOutSlowIn);
}
