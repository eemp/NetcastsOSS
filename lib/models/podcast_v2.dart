import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';

import 'package:hear2learn/models/podcast.dart' as legacy;
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

part 'podcast_v2.g.dart';

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
  queries: {
    'podcastsFTS': "SELECT podcasts.* FROM (SELECT rowid, name FROM podcasts_fts WHERE podcasts_fts.name MATCH 'infinite monkey') AS fts LEFT JOIN podcasts ON (rowid = id)",
  },
)
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1;

  Future<List<legacy.Podcast>> podcastsByGenre(genreId) async {
    return (
      select(podcasts)
        ..where((t) => t.primaryGenre.like("%$genreId%"))
        ..orderBy([(t) => OrderingTerm(expression: t.popularity, mode: OrderingMode.asc)])
        ..limit(10)
    ).map((Podcast podcast) {
      var episodes = jsonDecode(jsonDecode(podcast.episodes));
      return legacy.Podcast(
        artist: legacy.Artist.fromJson(json.decode(podcast.artist)),
        artwork30: podcast.artwork30,
        artwork60: podcast.artwork60,
        artwork100: podcast.artwork100,
        artwork600: podcast.artwork600,
        artworkOrig: podcast.artworkOrig,
        description: podcast.description,
        //List<Episode> episodes;
        episodesCount: episodes['count'],
        feed: podcast.feed,
        //List<Genre> genres;
        id: podcast.id,
        //DateTime lastModifiedDate;
        logoUrl: podcast.logoUrl,
        name: podcast.name,
        //primaryGenre: podcast.primaryGenre,
        //popularity: podcast.popularity,
        title: podcast.title,
        //DateTime releaseDate;
        url: podcast.url,
      );
    }).get();
  }

  Future<List<legacy.Podcast>> searchPodcastsByTextQuery(String textQuery, { int pageSize = 10, int page = 0 }) async {
    final int offset = page * pageSize;
    return (
      customSelectQuery(
        '''
        SELECT podcasts.*
        FROM (
          SELECT rowid, name FROM podcasts_fts
          WHERE podcasts_fts.name MATCH '$textQuery'
        ) AS fts LEFT JOIN podcasts ON (rowid = id)
        LIMIT $pageSize
        OFFSET $offset
        '''
      ).get().then((rows) =>
        rows.map((row) {
          var podcast = row.data;
          var episodes = jsonDecode(jsonDecode(podcast['episodes']));
          return legacy.Podcast(
            artist: legacy.Artist.fromJson(json.decode(podcast['artist'])),
            artwork30: podcast['artwork30'],
            artwork60: podcast['artwork60'],
            artwork100: podcast['artwork100'],
            artwork600: podcast['artwork600'],
            artworkOrig: podcast['artworkOrig'],
            description: podcast['description'],
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
        }).toList()
      )
    );
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    await loadLocalPodcastsDB();

    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(await getLocalPodcastsDBPath());
    return VmDatabase(file);
  });
}

void loadLocalPodcastsDB() async {
  // Construct a file path to copy database to
  String path = await getLocalPodcastsDBPath();

  // Only copy if the database doesn't exist
  if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
    // Load database from asset and copy
    ByteData data = await rootBundle.load(join('assets', 'data', 'podcasts.sqlite3'));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // Save copied asset to documents
    await new File(path).writeAsBytes(bytes);
  }
}

Future<String> getLocalPodcastsDBPath() async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  return join(documentsDirectory.path, "assets_data_podcasts.sqlite3");
}
