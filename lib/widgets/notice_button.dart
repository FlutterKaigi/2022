import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class NoticeButton extends StatelessWidget {
  const NoticeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return ClipRRect(
      borderRadius: BorderRadius.circular(48.0),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.green],
          ),
        ),
        child: Tooltip(
          message: appLocalizations.tweet,
          child: TextButton(
            onPressed: () async {
              await launch(
                'https://twitter.com/FlutterKaigi',
                webOnlyWindowName: '_blank',
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                appLocalizations.checkLatestNews,
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
