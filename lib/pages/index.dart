import 'package:confwebsite2022/gen/assets.gen.dart';
import 'package:confwebsite2022/responsive_layout_builder.dart';
import 'package:confwebsite2022/util/scroll_util.dart';
import 'package:confwebsite2022/widgets/background.dart';
import 'package:confwebsite2022/widgets/custom_button.dart';
import 'package:confwebsite2022/widgets/features.dart';
import 'package:confwebsite2022/widgets/footer.dart';
import 'package:confwebsite2022/widgets/sessions.dart';
import 'package:confwebsite2022/widgets/social.dart';
import 'package:confwebsite2022/widgets/sponsor.dart';
import 'package:confwebsite2022/widgets/staff.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

enum MenuItem { pastEvent, event, tweet, staff, timetable, sponsor }

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
            case MenuItem.pastEvent:
              urlString = 'https://flutterkaigi.jp/2021';
              break;
            case MenuItem.event:
              urlString = 'https://flutter-jp.connpass.com/';
              break;
            case MenuItem.tweet:
              urlString =
                  'https://twitter.com/intent/tweet?hashtags=FlutterKaigi';
              break;
            case MenuItem.staff:
              await animationScroll(MenuItem.staff);
              return;
            case MenuItem.timetable:
              await animationScroll(MenuItem.timetable);
              return;
            case MenuItem.sponsor:
              await animationScroll(MenuItem.sponsor);
              return;
          }
          await launch(
            urlString,
            webOnlyWindowName: '_blank',
          );
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuItem>>[
          if (showSchedule) ...[
            PopupMenuItem<MenuItem>(
              child: Text(appLocalizations.schedule),
              value: MenuItem.timetable,
            ),
          ],
          if (showSponsorLogo) ...[
            PopupMenuItem<MenuItem>(
              child: Text(appLocalizations.sponsor),
              value: MenuItem.sponsor,
            ),
          ],
          PopupMenuItem<MenuItem>(
            child: Text(appLocalizations.executive_committee),
            value: MenuItem.staff,
          ),
          const PopupMenuItem<MenuItem>(
            value: MenuItem.pastEvent,
            child: Text('FlutterKaigi 2021'),
          ),
          PopupMenuItem<MenuItem>(
            value: MenuItem.event,
            child: Text(appLocalizations.other_event),
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
      if (showSchedule) ...[
        Container(
          margin: const EdgeInsets.all(8),
          child: TextButton(
            child: Text(appLocalizations.schedule),
            onPressed: () async => await animationScroll(MenuItem.timetable),
          ),
        ),
      ],
      if (showSponsorLogo) ...[
        Container(
          margin: const EdgeInsets.all(8),
          child: TextButton(
            child: Text(appLocalizations.sponsor),
            onPressed: () async => await animationScroll(MenuItem.sponsor),
          ),
        ),
      ],
      Container(
        margin: const EdgeInsets.all(8),
        child: TextButton(
          child: Text(appLocalizations.executive_committee),
          onPressed: () async => await animationScroll(MenuItem.staff),
        ),
      ),
      Container(
        margin: const EdgeInsets.all(8),
        child: PopupMenuButton<MenuItem>(
          offset: const Offset(0, 40),
          child: TextButton.icon(
            label: Text(appLocalizations.event),
            icon: Icon(
              Icons.calendar_month,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: null,
          ),
          onSelected: (MenuItem result) async {
            String urlString;
            switch (result) {
              case MenuItem.pastEvent:
                urlString = 'https://flutterkaigi.jp/2021';
                break;
              case MenuItem.event:
                urlString = 'https://flutter-jp.connpass.com/';
                break;
              case MenuItem.tweet:
                urlString =
                    'https://twitter.com/intent/tweet?hashtags=FlutterKaigi';
                break;
              case MenuItem.staff:
                await animationScroll(MenuItem.staff);
                return;
              case MenuItem.timetable:
                await animationScroll(MenuItem.timetable);
                return;
              case MenuItem.sponsor:
                await animationScroll(MenuItem.sponsor);
                return;
            }
            await launch(
              urlString,
              webOnlyWindowName: '_blank',
            );
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
                value: MenuItem.pastEvent,
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
                value: MenuItem.event,
              ),
            ];
          },
        ),
      ),
      Container(
        margin: const EdgeInsets.all(8),
        child: Tooltip(
          message: appLocalizations.letsTweet,
          child: Link(
            uri: Uri.parse(
                'https://twitter.com/intent/tweet?hashtags=FlutterKaigi'),
            target: LinkTarget.blank,
            builder: (BuildContext ctx, FollowLink? openLink) {
              return ElevatedButton.icon(
                onPressed: openLink,
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                ),
                icon: SvgPicture.asset(Assets.twitterWhite, width: 20),
                label: Text(appLocalizations.tweet),
              );
            },
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
      final appLocalizations = AppLocalizations.of(context)!;
      final sizeFactor = (layout == ResponsiveLayout.slim) ? 0.6 : 1.0;

      return SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            SvgPicture.asset(
              Assets.flutterkaigiLogo,
              width: logoWidth * sizeFactor,
            ),
            Center(
              child: Text(
                'FlutterKaigi',
                style: titleTextStyle.apply(fontSizeFactor: sizeFactor),
              ),
            ),
            Gap(32 * sizeFactor),
            Center(
              child: Text(
                '@ONLINE / November 16-18, 2022',
                style: subtitleTextStyle.apply(fontSizeFactor: sizeFactor),
              ),
            ),
            const Gap(32),
            CustomButton(
                isShow: initialLaunched,
                colors:
                    initialLaunched ? const [Colors.blue, Colors.green] : null,
                title: appLocalizations.checkLatestNews,
                message: appLocalizations.tweet,
                url: 'https://twitter.com/FlutterKaigi'),
            const Gap(16),
            CustomButton(
                isShow: startApply,
                colors: startApply ? const [Colors.red, Colors.orange] : null,
                title: appLocalizations.applyMainEvent,
                message: appLocalizations.openMainEventPage,
                // 2022
                url: 'https://connpass.com/event/262916/'),
            const Gap(16),
            CustomButton(
              isShow: startApply,
              colors:
                  startApply ? const [Colors.teal, Colors.lightGreen] : null,
              title: appLocalizations.applyHandsonEvent,
              message: appLocalizations.openHandsonEventPage,
              // 2022
              url: 'https://connpass.com/event/263057/',
            ),
            const Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  isShow: initialLaunched || startSession,
                  colors:
                      startSession ? const [Colors.green, Colors.teal] : null,
                  title: appLocalizations.session,
                  message: startSession
                      ? appLocalizations.submitProposal
                      : appLocalizations.waitFor,
                  url: startSession
                      ? 'https://fortee.jp/flutterkaigi-2022/speaker/proposal/cfp'
                      : '',
                ),
                CustomButton(
                  isShow: initialLaunched || announceSponsor,
                  colors: announceSponsor
                      ? const [Colors.blue, Colors.indigo]
                      : null,
                  title: appLocalizations.sponsor,
                  message: announceSponsor
                      ? appLocalizations.becomeSponsor
                      : appLocalizations.waitFor,
                  url: announceSponsor
                      ? (startSponsor
                          ? 'https://fortee.jp/flutterkaigi-2022/sponsor/form'
                          : 'https://docs.google.com/presentation/d/1HEwDIi6rxzKUnZmu7EKkwR04bvTQnSjWjpw3ldunczM/edit?usp=sharing')
                      : '',
                ),
              ],
            ),
            const Gap(16),
            const Social(),
            const Gap(32),
            if (showSchedule) ...[
              const SessionList(
                key: GlobalObjectKey(MenuItem.timetable),
              ),
              const Gap(32),
            ],
            if (showSponsorLogo) ...[
              const SponsorSection(
                key: GlobalObjectKey(MenuItem.sponsor),
              ),
              const Gap(32),
            ],
            const StaffSection(key: GlobalObjectKey(MenuItem.staff)),
            Footer(layout: layout),
          ],
        ),
      );
    });
  }
}
