import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:uuid/uuid.dart';

part 'episode_download.jorm.dart';

class EpisodeDownload {
  @IgnoreColumn()
  static final Uuid uuid = new Uuid();

  DateTime created;
  @Column(length: 256, isNullable: false)
  String downloadPath;
  @Column(length: 256, isNullable: false)
  String episodeUrl;
  @PrimaryKey()
  String id;

  EpisodeDownload({
    this.created,
    this.downloadPath,
    this.episodeUrl,
    this.id,
  }) {
    this.id ??= uuid.v4();
  }

  String toString() {
    return 'Id = ${id}: Created on ${created.toString()}, episodeUrl = ${episodeUrl.toString()}, downloadPath: ${downloadPath}';
  }

  static String createNewId() {
    return uuid.v4();
  }
}

@GenBean()
class EpisodeDownloadBean extends Bean<EpisodeDownload> with _EpisodeDownloadBean {
  String get tableName => 'episode_download';

  EpisodeDownloadBean(Adapter adapter) : super(adapter);
}
