import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:uuid/uuid.dart';

part 'episode_action.jorm.dart';

enum EpisodeActionType {
  DOWNLOAD,
  FAVORITE,
  PLAY,
}

class EpisodeAction {
  @IgnoreColumn()
  static final Uuid uuid = Uuid();

  DateTime created;
  @Column(length: 0, isNullable: false)
  String details;
  @Column(length: 0, isNullable: false)
  String type;
  @Column(length: 0, isNullable: false)
  String url;
  @PrimaryKey(length: 36)
  String id;

  EpisodeAction({
    EpisodeActionType actionType,
    this.created,
    this.details,
    this.type,
    this.url,
    this.id,
  }) {
    created ??= DateTime.now();
    id ??= uuid.v4();
    type = actionType != null ? actionType.toString() : type;
  }

  EpisodeAction copyWith({
    DateTime created,
    String details,
    String id,
    String type,
    String url,
  }) {
    return EpisodeAction(
      created: created ?? this.created,
      details: details ?? this.details,
      id: id ?? this.id,
      type: type ?? this.type,
      url: url ?? this.url,
    );
  }

  @override
  String toString() {
    return 'Id = $id: Created on ${created.toString()}, url = $url, details: $details';
  }

  static String createNewId() {
    return uuid.v4();
  }
}

@GenBean()
class EpisodeActionBean extends Bean<EpisodeAction> with _EpisodeActionBean {
  @override
  String get tableName => 'episode_action';

  // ignore: always_specify_types
  EpisodeActionBean(Adapter adapter) : super(adapter);
}
