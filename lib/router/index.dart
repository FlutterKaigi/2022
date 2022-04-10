import 'package:confwebsite2022/pages/index.dart';
import 'package:confwebsite2022/router/simple_route.dart';
import 'package:flutter/material.dart';

Route<dynamic> buildRouters(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return defaultRoute();
    default:
      return defaultRoute();
  }
}

SimpleRoute defaultRoute() {
  return SimpleRoute(
      name: '/',
      title: 'FlutterKaigi 2022',
      builder: (context) => const TopPage());
}
