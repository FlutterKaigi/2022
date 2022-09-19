import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SessionPage extends StatelessWidget {
  const SessionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.session),
        leading: IconButton(
          icon: Icon(Icons.adaptive.arrow_back),
          tooltip: appLocalizations.back,
          onPressed: () => context.pop(),
        ),
      ),
      body: const Contents(),
    );
  }
}

class Contents extends ConsumerWidget {
  const Contents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
