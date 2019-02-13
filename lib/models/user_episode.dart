import 'dart:convert';
import 'package:hear2learn/models/episode.dart';
import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:uuid/uuid.dart';

part 'user_episode.jorm.dart';

class UserEpisode {
  @IgnoreColumn()
  static final Uuid uuid = Uuid();

  DateTime created;
  @Column(length: 0, isNullable: false)
  String details;
  @Column(length: 0, isNullable: false)
  String url;
  @PrimaryKey(length: 36)
  String id;

  UserEpisode({
    this.created,
    this.details,
    this.url,
    this.id,
  }) {
    created ??= DateTime.now();
    id ??= uuid.v4();
  }

  @override
  String toString() {
    return 'Id = $id: Created on ${created.toString()}, url = $url, details: $details';
  }

  Episode getEpisodeFromDetails() {
    final Map<String, dynamic> decodedDetails = jsonDecode(details);
    return Episode(
      description: decodedDetails['description'],
      media: decodedDetails['media'],
      podcastTitle: decodedDetails['podcastTitle'],
      podcastUrl: decodedDetails['podcastUrl'],
      pubDate: decodedDetails['pubDate'],
      size: decodedDetails['size'],
      title: decodedDetails['title'],
      url: decodedDetails['url'],
    );
  }

  static String createNewId() {
    return uuid.v4();
  }
}

@GenBean()
class UserEpisodeBean extends Bean<UserEpisode> with _UserEpisodeBean {
  @override
  String get tableName => 'user_episode';

  // ignore: always_specify_types
  UserEpisodeBean(Adapter adapter) : super(adapter);
}
