import 'package:confwebsite2022/data/sponsor.dart';
import 'package:confwebsite2022/widgets/divider_with_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SponsorSection extends StatelessWidget {
  const SponsorSection({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          DividerWithTitle(text: appLocalizations.sponsor),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                SponsorList(
                  header: appLocalizations.sponsorPlatinum,
                  sponsors: kPlatinumSponsorList,
                ),
                SponsorList(
                  header: appLocalizations.sponsorGold,
                  sponsors: kGoldSponsorList,
                ),
                SponsorList(
                  header: appLocalizations.sponsorSilver,
                  sponsors: kSilverSponsorList,
                ),
                SponsorList(
                  header: appLocalizations.sponsorBronze,
                  sponsors: kBronzeSponsorList,
                ),
                SponsorList(
                  header: appLocalizations.sponsorMedia,
                  sponsors: kMediaSponsorList,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SponsorList extends StatelessWidget {
  const SponsorList({
    super.key,
    required this.header,
    required this.sponsors,
  });
  final String header;
  final List<Map<String, String>> sponsors;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          Text(
            header,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Wrap(
            children: sponsors.map((sponsor) {
              return SponsorItem(
                name: sponsor['name']!,
                logo: sponsor['logo']!,
                url: sponsor['url']!,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class SponsorItem extends StatelessWidget {
  const SponsorItem({
    super.key,
    required this.name,
    required this.logo,
    required this.url,
  });
  final String name;
  final String logo;
  final String url;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (await canLaunch(url)) {
          await launch(url);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child: SvgPicture.asset(logo),
            ),
            FittedBox(child: Text(name)),
          ],
        ),
      ),
    );
  }

  bool validUrl(String url) {
    try {
      Uri.parse(url);
    } on FormatException catch (_) {
      return false;
    }
    return true;
  }
}
