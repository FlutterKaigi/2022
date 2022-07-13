import 'package:confwebsite2022/gen/assets.gen.dart';
import 'package:confwebsite2022/responsive_layout_builder.dart';
import 'package:confwebsite2022/widgets/background.dart';
import 'package:confwebsite2022/widgets/custom_button.dart';
import 'package:confwebsite2022/widgets/custom_notice_button.dart';
import 'package:confwebsite2022/widgets/features.dart';
import 'package:confwebsite2022/widgets/footer.dart';
import 'package:confwebsite2022/widgets/social.dart';
import 'package:confwebsite2022/widgets/staff.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

enum MenuItem { event, tweet }

class TopPage extends StatelessWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(builder: (context, layout, width) {
      return Scaffold(
        appBar: AppBar(
          title: SvgPicture.asset(
            Assets.flutterkaigiNavbarLightLogo,
            // height: kToolbarHeight,
            width: 240,
          ),
          centerTitle: false,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: buildActions(context, layout, width),
        ),
        body: Stack(
          children: [
            const Body(),
            BackgroundCanvas(size: MediaQuery.of(context).size),
          ],
        ),
      );
    });
  }

  List<Widget> buildActions(
      BuildContext context, ResponsiveLayout layout, double width) {
    if (layout == ResponsiveLayout.slim) {
      return buildPopupMenuButton(context);
    } else {
      return buildActionButtons(context);
    }
  }

  List<Widget> buildPopupMenuButton(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return [
      PopupMenuButton<MenuItem>(
        icon: const Icon(Icons.menu, color: Colors.black),
        onSelected: (MenuItem result) async {
          String urlString;
          switch (result) {
            case MenuItem.event:
              urlString = 'https://flutter-jp.connpass.com/';
              break;
            case MenuItem.tweet:
              urlString =
                  'https://twitter.com/intent/tweet?hashtags=FlutterKaigi';
              break;
          }
          await launch(
            urlString,
            webOnlyWindowName: '_blank',
          );
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuItem>>[
          PopupMenuItem<MenuItem>(
            value: MenuItem.event,
            child: Text(appLocalizations.event),
          ),
          PopupMenuItem<MenuItem>(
            value: MenuItem.tweet,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.blue,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(Assets.twitterWhite, width: 20),
                  const Gap(8),
                  Text(
                    appLocalizations.tweet,
                    style: Theme.of(context).textTheme.button?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    ];
  }

  List<Widget> buildActionButtons(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return [
      Container(
        margin: const EdgeInsets.all(8),
        child: Tooltip(
          message: 'https://flutter-jp.connpass.com/',
          child: TextButton(
            onPressed: () async {
              await launch(
                'https://flutter-jp.connpass.com/',
                webOnlyWindowName: '_blank',
              );
            },
            child: Text(appLocalizations.event),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.all(8),
        child: Tooltip(
          message: appLocalizations.letsTweet,
          child: ElevatedButton.icon(
            onPressed: () async {
              await launch(
                'https://twitter.com/intent/tweet?hashtags=FlutterKaigi',
                webOnlyWindowName: '_blank',
              );
            },
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
            ),
            icon: SvgPicture.asset(Assets.twitterWhite, width: 20),
            label: Text(appLocalizations.tweet),
          ),
        ),
      ),
    ];
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  TextStyle get titleTextStyle => const TextStyle(fontSize: 64);

  TextStyle get subtitleTextStyle => const TextStyle(fontSize: 36);

  TextStyle get thanksTextStyle => const TextStyle(fontSize: 14);

  int get logoWidth => 320;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return ResponsiveLayoutBuilder(builder: (context, layout, width) {
      final sizeFactor = (layout == ResponsiveLayout.slim) ? 0.6 : 1.0;

      return CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        Assets.flutterkaigiLogo,
                        width: logoWidth * sizeFactor,
                      ),
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'FlutterKaigi',
                          style:
                              titleTextStyle.apply(fontSizeFactor: sizeFactor),
                        ),
                      ),
                      Gap(32 * sizeFactor),
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          '@ONLINE / November 16-18, 2022',
                          style: subtitleTextStyle.apply(
                              fontSizeFactor: sizeFactor),
                        ),
                      ),
                      const Gap(32),
                      CustomNoticeButton(
                        isShow: initialLaunched,
                        title: appLocalizations.checkLatestNews,
                        message: appLocalizations.tweet,
                        onPress: () async {
                          await launch(
                            'https://twitter.com/FlutterKaigi',
                            webOnlyWindowName: '_blank',
                          );
                        },
                      ),
                      const Gap(16),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButton(
                              isShow: !initialLaunched,
                              title: appLocalizations.session,
                              message: startSession
                                  ? appLocalizations.submitProposal
                                  : appLocalizations.waitFor,
                              onPress: startSession
                                  ? () async {
                                      await launch(
                                        'https://fortee.jp/flutterkaigi-2022/speaker/proposal/cfp',
                                        webOnlyWindowName: '_blank',
                                      );
                                    }
                                  : null,
                            ),
                            CustomButton(
                              isShow: !initialLaunched,
                              title: appLocalizations.sponsor,
                              message: announceSponsor
                                  ? appLocalizations.becomeSponsor
                                  : appLocalizations.waitFor,
                              onPress: announceSponsor
                                  ? () async {
                                      await launch(
                                        startSponsor
                                            ? 'https://fortee.jp/flutterkaigi-2022/sponsor/form'
                                            : 'https://docs.google.com/presentation/d/1HEwDIi6rxzKUnZmu7EKkwR04bvTQnSjWjpw3ldunczM/edit?usp=sharing',
                                        webOnlyWindowName: '_blank',
                                      );
                                    }
                                  : null,
                            ),
                          ],
                        ),
                      ),
                      const Gap(16),
                      const Social(),
                    ],
                  ),
                ),
                const Gap(32),
                const StaffSection(),
                const Spacer(),
                Footer(layout: layout),
              ],
            ),
          ),
        ],
      );
    });
  }
}
