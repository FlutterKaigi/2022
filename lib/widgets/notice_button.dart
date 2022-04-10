import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class NoticeButton extends StatelessWidget {
  const NoticeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.green],
        ),
      ),
      child: Tooltip(
        message: appLocalizations.tweet,
        child: ElevatedButton(
          onPressed: () async {
            await launch(
              'https://twitter.com/FlutterKaigi',
              webOnlyWindowName: '_blank',
            );
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.all(24),
            primary: Colors.transparent,
            onPrimary: Colors.black87,
          ),
          child: Text(
            appLocalizations.checkLatestNews,
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
