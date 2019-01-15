import 'package:hear2learn/models/episode.dart';

class Podcast {
  String description;
  List<Episode> episodes;
  String logoUrl;
  String title;
  String url;

  Podcast({
    this.description,
    this.episodes,
    this.logoUrl,
    this.title,
    this.url,
  });

  @override
  String toString() {
    return 'Podcast[description=$description, episodes=${episodes.toString()}, logoUrl=$logoUrl, title=$title, url=$url]';
  }
}
