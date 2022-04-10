import 'package:confwebsite2022/data/link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkModel {
  LinkModel(this.name, this.url);

  final String name;
  final String url;
}

class Social extends StatelessWidget {
  const Social({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> socialItem() {
      return kSocialLinks.map((link) {
        return IconButton(
          tooltip: link['url'],
          icon: SvgPicture.asset(
            '/${link['name']}.svg',
            width: 60,
          ),
          onPressed: () async {
            await launch(link['url']!);
          },
          mouseCursor: SystemMouseCursors.click,
        );
      }).toList();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[...socialItem()],
    );
  }
}
