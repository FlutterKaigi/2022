import 'package:confwebsite2022/gen/assets.gen.dart';
import 'package:confwebsite2022/responsive_layout_builder.dart';
import 'package:confwebsite2022/widgets/background.dart';
import 'package:confwebsite2022/widgets/footer.dart';
import 'package:confwebsite2022/widgets/notice_button.dart';
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
        child: PopupMenuButton(
          offset: const Offset(0, 40),
          child: TextButton.icon(
            label: Text(appLocalizations.event),
            icon: Icon(
              Icons.calendar_month,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: null,
          ),
          onSelected: (value) async {
            switch (value) {
              case '/flutterkaigi2021':
                {
                  await launch(
                    'https://flutterkaigi.jp/2021',
                    webOnlyWindowName: '_blank',
                  );
                  break;
                }
              default:
                {
                  await launch(
                    'https://flutter-jp.connpass.com/',
                    webOnlyWindowName: '_blank',
                  );
                  break;
                }
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                child: Text(
                  'FlutterKaigi 2021',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                  ),
                  strutStyle: StrutStyle(
                    fontSize: 18,
                    height: 1.3,
                  ),
                ),
                value: '/flutterkaigi2021',
              ),
              PopupMenuItem(
                child: Text(
                  appLocalizations.other_event,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                  ),
                  strutStyle: const StrutStyle(
                    fontSize: 18,
                    height: 1.3,
                  ),
                ),
                value: '/other',
              ),
            ];
          },
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
                      const NoticeButton(),
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
