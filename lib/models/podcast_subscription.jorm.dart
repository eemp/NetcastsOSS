// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast_subscription.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _PodcastSubscriptionBean implements Bean<PodcastSubscription> {
  final id = StrField('id');
  final isSubscribed = BoolField('is_subscribed');
  final created = DateTimeField('created');
  final podcastUrl = StrField('podcast_url');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        isSubscribed.name: isSubscribed,
        created.name: created,
        podcastUrl.name: podcastUrl,
      };
  PodcastSubscription fromMap(Map map) {
    PodcastSubscription model = PodcastSubscription();
    model.id = adapter.parseValue(map['id']);
    model.isSubscribed = adapter.parseValue(map['is_subscribed']);
    model.created = adapter.parseValue(map['created']);
    model.podcastUrl = adapter.parseValue(map['podcast_url']);

    return model;
  }

  List<SetColumn> toSetColumns(PodcastSubscription model,
      {bool update = false, Set<String> only}) {
    List<SetColumn> ret = [];

    if (only == null) {
      ret.add(id.set(model.id));
      ret.add(isSubscribed.set(model.isSubscribed));
      ret.add(created.set(model.created));
      ret.add(podcastUrl.set(model.podcastUrl));
    } else {
      if (only.contains(id.name)) ret.add(id.set(model.id));
      if (only.contains(isSubscribed.name))
        ret.add(isSubscribed.set(model.isSubscribed));
      if (only.contains(created.name)) ret.add(created.set(model.created));
      if (only.contains(podcastUrl.name))
        ret.add(podcastUrl.set(model.podcastUrl));
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists: false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addStr(id.name, primary: true, length: 36, isNullable: false);
    st.addBool(isSubscribed.name, isNullable: false);
    st.addDateTime(created.name, isNullable: false);
    st.addStr(podcastUrl.name, length: 0, isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(PodcastSubscription model,
      {bool cascade: false}) async {
    final Insert insert = inserter.setMany(toSetColumns(model));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<PodcastSubscription> models) async {
    final List<List<SetColumn>> data =
        models.map((model) => toSetColumns(model)).toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(PodcastSubscription model,
      {bool cascade: false}) async {
    final Upsert upsert = upserter.setMany(toSetColumns(model));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<PodcastSubscription> models) async {
    final List<List<SetColumn>> data = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(toSetColumns(model).toList());
    }
    final UpsertMany upsert = upserters.addAll(data);
    await adapter.upsertMany(upsert);
    return;
  }

  Future<int> update(PodcastSubscription model,
      {bool cascade: false, bool associate: false, Set<String> only}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only));
    return adapter.update(update);
  }

  Future<void> updateMany(List<PodcastSubscription> models) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(toSetColumns(model).toList());
      where.add(this.id.eq(model.id));
    }
    final UpdateMany update = updaters.addAll(data, where);
    await adapter.updateMany(update);
    return;
  }

  Future<PodcastSubscription> find(String id,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(String id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<PodcastSubscription> models) async {
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }
}
