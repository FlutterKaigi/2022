import 'package:confwebsite2022/data/link.dart';
import 'package:confwebsite2022/gen/assets.gen.dart';
import 'package:confwebsite2022/responsive_layout_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:styled_text/styled_text.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  Footer({Key? key, required this.layout}) : super(key: key);

  ResponsiveLayout layout;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final footerLinks = <Map<String, String>>[
      {
        'name': appLocalizations.codeOfConduct,
        'url':
            'https://flutterkaigi.github.io/flutterkaigi/Code-of-Conduct.ja.html',
      },
      {
        'name': appLocalizations.privacyPolicy,
        'url':
            'https://flutterkaigi.github.io/flutterkaigi/Privacy-Policy.ja.html',
      },
      {
        'name': appLocalizations.contactUs,
        'url':
            'https://docs.google.com/forms/d/e/1FAIpQLSemYPFEWpP8594MWI4k3Nz45RJzMS7pz1ufwtnX4t3V7z2TOw/viewform',
      },
    ];

    final footerItem = footerLinks.map((link) {
      return _FooterButton(
          message: link['name']!,
          text: link['name']!,
          onPressed: () async {
            await launch(link['url']!);
          });
    }).toList()
      ..add(
        _FooterButton(
            message: appLocalizations.licenses,
            text: appLocalizations.licenses,
            onPressed: () {
              showLicensePage(
                context: context,
              );
            }),
      );

    final socialItem = kSocialLinks.map((dynamic link) {
      return _FooterButton(
        text: link['title'],
        message: link['url'],
        icon: link['name'],
        onPressed: () async {
          await launch(link['url']!);
        },
      );
    }).toList();

    final pastItem = kPastEvents.map((dynamic link) {
      return _FooterButton(
        message: link['url'],
        text: link['name'],
        onPressed: () async {
          await launch(link['url']!);
        },
      );
    }).toList();

    return SizedBox(
      child: Column(
        children: [
          const CustomDivider(
            thickness: 4,
            gradient: LinearGradient(
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              colors: [
                Colors.grey,
                Colors.pinkAccent,
                Colors.blueAccent,
              ],
              stops: [
                0.0,
                0.5,
                1.0,
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            color: const Color.fromRGBO(48, 60, 66, 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: SvgPicture.asset(
                    Assets.flutterkaigiNavbarDarkLogo,
                    // height: kToolbarHeight,
                    width: 240,
                  ),
                ),
                const Gap(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (layout == ResponsiveLayout.slim)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      width: 180,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: footerItem,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      width: 180,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: socialItem,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Gap(16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      width: 180,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: pastItem,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    if (layout != ResponsiveLayout.slim)
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    width: 240,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: footerItem,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    width: 240,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: socialItem,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    width: 240,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: pastItem,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const Gap(16),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    appLocalizations.copyright,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const Gap(8),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    appLocalizations.disclaimer,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const Gap(4),
                Align(
                  alignment: Alignment.topLeft,
                  child: StyledText(
                    text: appLocalizations.trademark,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    tags: {
                      'FlutterLogo': StyledTextWidgetTag(
                        const FlutterLogo(),
                      ),
                    },
                  ),
                ),
                const Gap(32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterButton extends StatelessWidget {
  const _FooterButton({
    Key? key,
    required this.message,
    this.text,
    this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String message;
  final String? text;
  final String? icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return Tooltip(
          message: message,
          child: Row(children: [
            TextButton.icon(
              onPressed: onPressed,
              icon: SvgPicture.asset(
                '/$icon.svg',
                width: 24,
              ),
              label: Text(
                text!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ]));
    }
    return Tooltip(
        message: message,
        child: Row(children: [
          TextButton(
            onPressed: onPressed,
            child: Text(
              text!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ]));
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key? key,
    this.height = 16,
    this.thickness = 1,
    this.indent = 0,
    this.endIndent = 0,
    required this.gradient,
  }) : super(key: key);

  final double height;
  final double thickness;
  final double indent;
  final double endIndent;
  final LinearGradient gradient;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: height,
        ),
        Container(
          height: thickness,
          margin: EdgeInsetsDirectional.only(
            start: indent,
            end: endIndent,
          ),
          decoration: BoxDecoration(
            gradient: gradient,
          ),
        ),
      ],
    );
  }
}
