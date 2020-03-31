import 'package:hear2learn/models/podcast_v2.dart';
import 'package:hear2learn/models/podcast.dart' as legacy;
import 'package:sqljocky5/sqljocky.dart';
import 'package:test/test.dart';

void main() {
  test('Connect to mysql with sqljocky', () async {
    ConnectionSettings connSettings = ConnectionSettings(
      db: "uBvzqxFkIM",
      host: "remotemysql.com",
      password: "eH5aZObkUB",
      port: 3306,
      user: "uBvzqxFkIM",
    );
    var conn = await MySqlConnection.connect(connSettings);

    Results result = await conn.execute('''
        SELECT *
        FROM podcasts
        WHERE primary_genre LIKE '%1318%'
        LIMIT 10
    ''');
    expect(result.length, equals(10));

    await conn.close();
  });

  test('Connect to mysql with MyDatabase', () async {
    MyDatabase db = MyDatabase();
    List<legacy.Podcast> results = await db.podcastsByGenre('1318');
    expect(results.length, equals(10));
  });
}
