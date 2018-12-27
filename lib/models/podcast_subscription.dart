import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:uuid/uuid.dart';

part 'podcast_subscription.jorm.dart';

class PodcastSubscription {
  @IgnoreColumn()
  final Uuid uuid = new Uuid();

  @PrimaryKey()
  String id;
  bool isSubscribed;
  DateTime created;
  DateTime lastUpdated;
  @Column(length: 256, isNullable: false)
  String podcastUrl;

  PodcastSubscription({
    this.created,
    this.id,
    this.isSubscribed,
    this.lastUpdated,
    this.podcastUrl,
  }) {
    this.id ??= uuid.v4();
  }

  String toString() {
    return 'Id = ${id}: Created on ${created.toString()}, isSubscribed = ${isSubscribed.toString()}, podcastUrl: ${podcastUrl}';
  }
}

@GenBean()
class PodcastSubscriptionBean extends Bean<PodcastSubscription> with _PodcastSubscriptionBean {
  String get tableName => 'podcast_subscription';

  /// Field DSL for msg column
  final StrField podcastUrl = new StrField('podcastUrl');

  PodcastSubscriptionBean(Adapter adapter) : super(adapter);
}
