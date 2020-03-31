import 'dart:async';
import 'dart:convert';

import 'package:hear2learn/models/podcast.dart' as legacy;
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';

part 'podcast_v2.g.dart';

typedef DatabaseOpener = FutureOr<QueryExecutor> Function();

const String SQLITE_STRATEGY = 'sqlite3';
const String MYSQL_STRATEGY = 'mysql';

final Map<String, dynamic> QUERIES = <String, dynamic>{
  'podcastsByGenre': {
    'default': (String genreId) => '''
      SELECT *
      FROM podcasts
      WHERE primary_genre LIKE '%$genreId%'
      ORDER BY popularity ASC
      LIMIT 10
    ''',
  },
  'searchPodcastsByTextQuery': {
    'mysql': (String textQuery, { int offset = 0, int pageSize = 10 }) => '''
      SELECT *
      FROM podcasts
      WHERE MATCH(name, description) AGAINST ('$textQuery' IN NATURAL LANGUAGE MODE)
      LIMIT $pageSize
      OFFSET $offset
    ''',
    'sqlite3': (String textQuery, { int offset = 0, int pageSize = 10 }) => '''
      SELECT podcasts.*
      FROM (
        SELECT rowid, name FROM podcasts_fts
        WHERE podcasts_fts.name MATCH '$textQuery'
      ) AS fts LEFT JOIN podcasts ON (rowid = id)
      LIMIT $pageSize
      OFFSET $offset
    ''',
  },
};

class Podcasts extends Table {
  TextColumn get artist => text().nullable()();
  TextColumn get artwork30 => text().nullable()();
  TextColumn get artwork60 => text().nullable()();
  TextColumn get artwork100 => text().nullable()();
  TextColumn get artwork600 => text().nullable()();
  TextColumn get artworkOrig => text().nullable()();
  TextColumn get description => text().nullable()();
  //List<Episode> episodes;
  TextColumn get episodes => text().nullable()();
  TextColumn get feed => text().nullable()();
  //List<Genre> genres;
  TextColumn get id => text().nullable()();
  //DateTime lastModifiedDate;
  TextColumn get logoUrl => text().nullable()(); // TODO(eemp): to be deprecated, removed
  TextColumn get name => text().nullable()();
  TextColumn get primaryGenre => text().nullable()();
  RealColumn get popularity => real().nullable()();
  TextColumn get title => text().nullable()(); // TODO(eemp): to be deprecated, removed
  //DateTime releaseDate;
  TextColumn get url => text().nullable()(); // TODO(eemp): to be deprecated, removed
}

@UseMoor(
  tables: [Podcasts],
)
class RemoteData extends _$MyDatabase {
  String strategy;
  var db;

  // we tell the database where to store the data with this constructor
  RemoteData({this.db, this.strategy}) : super(db) {
    if(this.strategy == MYSQL_STRATEGY) { // hack to avoid dropping mysql connection
      Timer.periodic(Duration(seconds: 60), (Timer timer) {
        this.fakePing();
      });
    }
  }

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1;

  // ping to keep connection alive
  Future<void> fakePing() async {
    await customSelectQuery('SELECT 1').get();
  }

  Future<List<legacy.Podcast>> podcastsByGenre(genreId) async {
    const queryName = 'podcastsByGenre';

    final queryFn = QUERIES[queryName][strategy] != null
      ? QUERIES[queryName][strategy]
      : QUERIES[queryName]['default'];
    final query = queryFn(genreId);

    // if(strategy == MYSQL_STRATEGY) await db.reopen();
    // await db.ensureOpen();
    return (
      customSelectQuery(query)
      .get()
      .then((rows) => dbRowsToPodcasts(rows))
    );
  }

  Future<List<legacy.Podcast>> searchPodcastsByTextQuery(String textQuery, { int pageSize = 10, int page = 0 }) async {
    const queryName = 'searchPodcastsByTextQuery';

    final int offset = page * pageSize;
    final queryFn = QUERIES[queryName][strategy] != null
      ? QUERIES[queryName][strategy]
      : QUERIES[queryName]['default'];
    final query = queryFn(textQuery, offset: offset, pageSize: pageSize);

    // if(strategy == MYSQL_STRATEGY) await db.reopen();
    // await db.ensureOpen();
    return (
      customSelectQuery(query)
      .get()
      .then((rows) => dbRowsToPodcasts(rows))
    );
  }
}

List<legacy.Podcast> dbRowsToPodcasts(rows) {
  return rows.map<legacy.Podcast>((row) {
    var podcast = row.data;
    var artist = jsonDecode(podcast['artist'].toString());
    if(artist is String) artist = jsonDecode(artist); // hack needed to consolidate diff vs mysql and sqlite
    var episodes = jsonDecode(podcast['episodes'].toString());
    if(episodes is String) episodes = jsonDecode(episodes); // hack needed to consolidate diff vs mysql and sqlite

    return legacy.Podcast(
      artist: legacy.Artist.fromJson(artist),
      artwork30: podcast['artwork30'],
      artwork60: podcast['artwork60'],
      artwork100: podcast['artwork100'],
      artwork600: podcast['artwork600'],
      artworkOrig: podcast['artworkOrig'].toString(),
      description: podcast['description'].toString(),
      //List<Episode> episodes;
      episodesCount: episodes['count'],
      feed: podcast['feed'],
      //List<Genre> genres;
      id: podcast['id'],
      //DateTime lastModifiedDate;
      logoUrl: podcast['logoUrl'],
      name: podcast['name'],
      //primaryGenre: podcast['primaryGenre'],
      //popularity: podcast['popularity'],
      title: podcast['title'],
      //DateTime releaseDate;
      url: podcast['url'],
    );
  }).toList();
}
