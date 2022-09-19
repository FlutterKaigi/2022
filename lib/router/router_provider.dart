import 'package:confwebsite2022/pages/index.dart';
import 'package:confwebsite2022/pages/session.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => const TopPage(),
        routes: [
          GoRoute(
            path: 'session',
            pageBuilder: (_, state) => NoTransitionPage(
              key: state.pageKey,
              child: const SessionPage(),
            ),
          ),
        ],
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Text(state.error.toString()),
        ),
      ),
    ),
  ),
);
