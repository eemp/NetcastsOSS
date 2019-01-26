import 'dart:convert';
import 'package:hear2learn/models/episode.dart';
import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:uuid/uuid.dart';

part 'episode_download.jorm.dart';

class EpisodeDownload {
  @IgnoreColumn()
  static final Uuid uuid = Uuid();

  DateTime created;
  @Column(length: 0, isNullable: false)
  String details;
  @Column(length: 0, isNullable: false)
  String downloadPath;
  @Column(length: 0, isNullable: false)
  String episodeUrl;
  @PrimaryKey(length: 36)
  String id;

  EpisodeDownload({
    this.created,
    this.details,
    this.downloadPath,
    this.episodeUrl,
    this.id,
  }) {
    id ??= uuid.v4();
  }

  @override
  String toString() {
    return 'Id = $id: Created on ${created.toString()}, episodeUrl = ${episodeUrl.toString()}, downloadPath: $downloadPath, details: $details';
  }

  Episode getEpisodeFromDetails() {
    final Map<String, dynamic> decodedDetails = jsonDecode(details);
    return Episode(
      description: decodedDetails['description'],
      download: this,
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
class EpisodeDownloadBean extends Bean<EpisodeDownload> with _EpisodeDownloadBean {
  @override
  String get tableName => 'episode_download';

  // ignore: always_specify_types
  EpisodeDownloadBean(Adapter adapter) : super(adapter);
}
