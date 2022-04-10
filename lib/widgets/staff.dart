import 'package:confwebsite2022/data/staff.dart';
import 'package:confwebsite2022/gen/assets.gen.dart';
import 'package:confwebsite2022/responsive_layout_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class StaffSection extends StatelessWidget {
  const StaffSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    kStaffList.sort((a, b) => (a['name'] ?? '').compareTo(b['name'] ?? ''));

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Tooltip(
                message: appLocalizations.executive_committee,
                child: Text(
                  appLocalizations.executive_committee,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Tooltip(
                message: appLocalizations.alphabeticalOrder,
                child: Text(
                  appLocalizations.alphabeticalOrder,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: SizedBox(
                height: 400,
                child: Center(
                  child: GridView.extent(
                    shrinkWrap: true,
                    primary: false,
                    padding: const EdgeInsets.all(24),
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    maxCrossAxisExtent: 100,
                    children: kStaffList
                        .map(
                          (e) => StaffItem(
                            name: e['name'] ?? '',
                            photo: e['photo'] ?? '',
                            url: e['url'] ?? '',
                          ),
                        )
                        .toList(),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

class StaffItem extends StatelessWidget {
  const StaffItem({
    Key? key,
    required this.name,
    required this.photo,
    required this.url,
  }) : super(key: key);
  final String name;
  final String photo;
  final String url;

  @override
  Widget build(BuildContext context) {
    // final image = (photo.isNotEmpty
    //     ? AssetImage(photo)
    //     : const Svg(Assets.flutterkaigiLog)) as ImageProvider;

    final image = (photo.isNotEmpty && validUrl(photo)
        ? NetworkImage(photo)
        : const Svg(Assets.flutterkaigiLogo)) as ImageProvider;

    return InkWell(
      onTap: () async {
        if (await canLaunch(url)) {
          await launch(url);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 64,
            width: 64,
            child: ClipOval(
              child: FadeInImage(
                fit: BoxFit.cover,
                image: image,
                placeholder: MemoryImage(kTransparentImage),
              ),
            ),
          ),
          FittedBox(child: Text(name)),
        ],
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
