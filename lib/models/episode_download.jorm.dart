// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_download.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _EpisodeDownloadBean implements Bean<EpisodeDownload> {
  final created = DateTimeField('created');
  final downloadPath = StrField('download_path');
  final episodeUrl = StrField('episode_url');
  final id = StrField('id');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        created.name: created,
        downloadPath.name: downloadPath,
        episodeUrl.name: episodeUrl,
        id.name: id,
      };
  EpisodeDownload fromMap(Map map) {
    EpisodeDownload model = EpisodeDownload();
    model.created = adapter.parseValue(map['created']);
    model.downloadPath = adapter.parseValue(map['download_path']);
    model.episodeUrl = adapter.parseValue(map['episode_url']);
    model.id = adapter.parseValue(map['id']);

    return model;
  }

  List<SetColumn> toSetColumns(EpisodeDownload model,
      {bool update = false, Set<String> only}) {
    List<SetColumn> ret = [];

    if (only == null) {
      ret.add(created.set(model.created));
      ret.add(downloadPath.set(model.downloadPath));
      ret.add(episodeUrl.set(model.episodeUrl));
      ret.add(id.set(model.id));
    } else {
      if (only.contains(created.name)) ret.add(created.set(model.created));
      if (only.contains(downloadPath.name))
        ret.add(downloadPath.set(model.downloadPath));
      if (only.contains(episodeUrl.name))
        ret.add(episodeUrl.set(model.episodeUrl));
      if (only.contains(id.name)) ret.add(id.set(model.id));
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists: false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addDateTime(created.name, isNullable: false);
    st.addStr(downloadPath.name, length: 256, isNullable: false);
    st.addStr(episodeUrl.name, length: 256, isNullable: false);
    st.addStr(id.name, primary: true, isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(EpisodeDownload model, {bool cascade: false}) async {
    final Insert insert = inserter.setMany(toSetColumns(model));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<EpisodeDownload> models) async {
    final List<List<SetColumn>> data =
        models.map((model) => toSetColumns(model)).toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(EpisodeDownload model, {bool cascade: false}) async {
    final Upsert upsert = upserter.setMany(toSetColumns(model));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<EpisodeDownload> models) async {
    final List<List<SetColumn>> data = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(toSetColumns(model).toList());
    }
    final UpsertMany upsert = upserters.addAll(data);
    await adapter.upsertMany(upsert);
    return;
  }

  Future<int> update(EpisodeDownload model,
      {bool cascade: false, bool associate: false, Set<String> only}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only));
    return adapter.update(update);
  }

  Future<void> updateMany(List<EpisodeDownload> models) async {
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

  Future<EpisodeDownload> find(String id,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(String id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<EpisodeDownload> models) async {
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }
}
