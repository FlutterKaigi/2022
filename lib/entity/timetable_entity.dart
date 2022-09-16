import 'package:flutter/foundation.dart';

@immutable
class TimetableEntity {
  final List<Timetable> timetable;

  const TimetableEntity({this.timetable = const []});

  factory TimetableEntity.fromJson(Map<String, dynamic> json) =>
      json['timetable'] == null
          ? const TimetableEntity()
          : TimetableEntity(
              timetable:
                  json['timetable'].map((e) => Timetable.fromJson(e)).toList(),
            );

  Map<String, dynamic>? toJson() {
    final data = <String, dynamic>{};
    data['timetable'] = timetable.map((v) => v.toJson()).toList();
    return data;
  }

  @override
  String toString() => 'TimetableEntity(timetable: $timetable)';
}

@immutable
class Timetable {
  final String type;
  final String uuid;
  final String title;
  final String abstract;
  final Track track;
  final String startsAt;
  final int lengthMin;
  final Speaker speaker;
  final int favCount;

  const Timetable({
    this.type = '',
    this.uuid = '',
    this.title = '',
    this.abstract = '',
    this.track = const Track(),
    this.startsAt = '',
    this.lengthMin = 0,
    this.speaker = const Speaker(),
    this.favCount = 0,
  });

  factory Timetable.fromJson(Map<String, dynamic> json) => Timetable(
        type: json['type'],
        uuid: json['uuid'],
        title: json['title'],
        abstract: json['abstract'],
        track: Track.fromJson(json['track'] ?? {}),
        startsAt: json['starts_at'],
        lengthMin: json['length_min'],
        speaker: Speaker.fromJson(json['speaker'] ?? {}),
        favCount: json['fav_count'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['uuid'] = uuid;
    data['title'] = title;
    data['abstract'] = abstract;
    data['track'] = track.toJson();
    data['starts_at'] = startsAt;
    data['length_min'] = lengthMin;
    data['speaker'] = speaker.toJson();
    data['fav_count'] = favCount;
    return data;
  }

  @override
  String toString() {
    return 'Timetable(type: $type, uuid: $uuid, title: $title, abstract: $abstract, track: $track, startsAt: $startsAt, lengthMin: $lengthMin, speaker: $speaker, favCount: $favCount)';
  }
}

@immutable
class Track {
  final String name;
  final int sort;

  const Track({
    this.name = '',
    this.sort = 0,
  });

  factory Track.fromJson(Map<String, dynamic> json) => Track(
        name: json['name'],
        sort: json['sort'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['sort'] = sort;
    return data;
  }

  @override
  String toString() => 'Track(name: $name, sort: $sort)';
}

@immutable
class Speaker {
  final String name;
  final String kana;
  final String twitter;
  final String avatarUrl;

  const Speaker({
    this.name = '',
    this.kana = '',
    this.twitter = '',
    this.avatarUrl = '',
  });

  factory Speaker.fromJson(Map<String, dynamic> json) => Speaker(
        name: json['name'],
        kana: json['kana'],
        twitter: json['twitter'],
        avatarUrl: json['avatar_url'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['kana'] = kana;
    data['twitter'] = twitter;
    data['avatar_url'] = avatarUrl;
    return data;
  }

  @override
  String toString() {
    return 'Speaker(name: $name, kana: $kana, twitter: $twitter, avatarUrl: $avatarUrl)';
  }
}
