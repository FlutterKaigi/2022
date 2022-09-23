import 'dart:convert';

import 'package:confwebsite2022/entity/timetable_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

const kSkyblue = Color(0xFF4ACCEB);
const kBlue = Color(0xFF174C90);
const kRed = Color(0xFFCA2421);

final sessionList = FutureProvider((_) async {
  var response = await http
      .get(Uri.parse('https://fortee.jp/flutterkaigi-2022/api/timetable'));
  if (response.statusCode == 200) {
    var responseBody = utf8.decode(response.bodyBytes);
    final parsed = TimetableEntity.fromJson(jsonDecode(responseBody)).timetable;
    return Future.value(parsed.where((e) => e.track.name == 'Live').toList());
  }
  return Future.value(const TimetableEntity().timetable);
});

class SessionList extends ConsumerWidget {
  const SessionList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions = ref.watch(sessionList);

    return sessions.when(
      data: (list) => _SessionList(sessions: list),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _SessionList extends StatelessWidget {
  final List<Timetable> sessions;

  const _SessionList({
    Key? key,
    required this.sessions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final division = <int, List<Timetable>>{};
    for (final session in sessions) {
      final date = session.startsAt;
      if (date == null) continue;
      if (division[date.day] == null) {
        division[date.day] = <Timetable>[];
      }
      division[date.day]!.add(session);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(4),
          child: Tooltip(
            message: appLocalizations.timetableOrder,
            child: Text(
              appLocalizations.timetableOrder,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        for (var i = 0; i < division.values.length; i++) ...[
          const SizedBox(height: 16),
          Text(
            'Day ${i + 1}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          for (final session in division.values.elementAt(i)) ...[
            session.type.when(
              timeslot: () => _Timeslot(item: session),
              talk: () => _CardItem(item: session),
            ),
            const SizedBox(height: 8),
          ],
        ],
      ],
    );
  }
}

final dateTimeFormatter = DateFormat.Md('ja').add_Hm();
final timeFormatter = DateFormat.Hm('ja');

class _Timeslot extends StatelessWidget {
  final Timetable item;

  const _Timeslot({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class _CardItem extends StatelessWidget {
  final Timetable item;

  const _CardItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final sessionTimeRange = () {
      final startTime = item.startsAt?.toLocal();
      if (startTime == null) return '';
      final finishTime = startTime.add(Duration(minutes: item.lengthMin));
      return '${dateTimeFormatter.format(startTime)}-${timeFormatter.format(finishTime)}';
    }();

    return Tooltip(
      message: appLocalizations.checkSessionDetailsInFortee,
      child: ListTile(
        dense: true,
        leading: const Icon(Icons.movie),
        title: Text(
          item.title,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                item.speaker.name,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                sessionTimeRange,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
        trailing: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Tooltip(
                message: item.speaker.twitter,
                child: IconButton(
                  icon: SvgPicture.asset(
                    '/twitter_logo.svg',
                    width: 40,
                  ),
                  onPressed: () => launch(
                    'https://twitter.com/${item.speaker.twitter}',
                    webOnlyWindowName: '_blank',
                  ),
                ),
              ),
            ]),
        onTap: () => launch(item.url, webOnlyWindowName: '_blank'),
      ),
    );
  }
}
