import 'dart:convert';

import 'package:confwebsite2022/entity/timetable_entity.dart';
import 'package:confwebsite2022/responsive_layout_builder.dart';
import 'package:confwebsite2022/widgets/divider_with_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
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

final _selectedDayIndex = StateProvider((_) => 0);

class SessionList extends ConsumerWidget {
  const SessionList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions = ref.watch(sessionList);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: sessions.when(
        data: (list) => _SessionList(sessions: list),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const SizedBox.shrink(),
      ),
    );
  }
}

class _SessionList extends ConsumerWidget {
  final List<Timetable> sessions;

  const _SessionList({
    Key? key,
    required this.sessions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalizations = AppLocalizations.of(context)!;
    final division = <int, List<Timetable>>{};
    final selectedDay = ref.watch(_selectedDayIndex);
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
        DividerWithTitle(text: appLocalizations.schedule),
        const Gap(8),
        ResponsiveLayoutBuilder(builder: (context, layout, _) {
          switch (layout) {
            case ResponsiveLayout.slim:
              return _DaySelectorSlim(
                current: selectedDay,
                max: division.length,
              );
            case ResponsiveLayout.wide:
            case ResponsiveLayout.ultrawide:
              return _DaySelectorWide(
                current: selectedDay,
                max: division.length,
              );
          }
        }),
        for (final session in division.values.elementAt(selectedDay)) ...[
          session.type.when(
            timeslot: () => _Timeslot(item: session),
            talk: () => _CardItem(item: session),
          ),
          const Gap(8),
        ],
      ],
    );
  }
}

class _DaySelectorWide extends ConsumerWidget {
  final int current;
  final int max;

  const _DaySelectorWide({
    required this.current,
    required this.max,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        for (var i = 0; i < max; i++) ...[
          Expanded(
            child: Material(
              color: current == i ? kBlue : Colors.white,
              child: InkWell(
                onTap: () => ref.read(_selectedDayIndex.notifier).state = i,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: kBlue, width: 2),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text(
                      'Day ${i + 1}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: current == i ? Colors.white : kBlue,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Gap(8),
        ],
      ],
    );
  }
}

class _DaySelectorSlim extends ConsumerWidget {
  final int current;
  final int max;

  const _DaySelectorSlim({
    required this.current,
    required this.max,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < max; i++) ...[
          Material(
            color: current == i ? kBlue : Colors.white,
            child: InkWell(
              onTap: () => ref.read(_selectedDayIndex.notifier).state = i,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: kBlue, width: 2),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    'Day ${i + 1}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: current == i ? Colors.white : kBlue,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Gap(8),
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
