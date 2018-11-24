class Episode {
  String description;
  String media;
  String pubDate;
  int size;
  String title;
  String url;

  Episode({
    this.description,
    this.pubDate,
    this.size,
    this.title,
    this.url,
  });

  @override
  String toString() {
    return 'Episode[description=$description, media=$media, pubDate=$pubDate, size=$size, title=$title, url=$url, ]';
  }
}
