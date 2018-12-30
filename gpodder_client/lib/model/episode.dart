part of swagger.api;

class Episode {

  String description = null;


  String mygpoLink = null;


  String title = null;


  String podcastTitle = null;


  String podcastUrl = null;


  DateTime released = null;


  String url = null;


  String website = null;

  Episode();

  @override
  String toString() {
    return 'Episode[description=$description, mygpoLink=$mygpoLink, title=$title, podcastTitle=$podcastTitle, podcastUrl=$podcastUrl, released=$released, url=$url, website=$website, ]';
  }

  Episode.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    description =
        json['description']
    ;
    mygpoLink =
        json['mygpo_link']
    ;
    title =
        json['title']
    ;
    podcastTitle =
        json['podcast_title']
    ;
    podcastUrl =
        json['podcast_url']
    ;
    released = json['released'] == null ? null : DateTime.parse(json['released']);
    url =
        json['url']
    ;
    website =
        json['website']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'mygpoLink': mygpoLink,
      'title': title,
      'podcastTitle': podcastTitle,
      'podcastUrl': podcastUrl,
      'released': released == null ? '' : released.toUtc().toIso8601String(),
      'url': url,
      'website': website
     };
  }

  static List<Episode> listFromJson(List<dynamic> json) {
    return json == null ? new List<Episode>() : json.map((value) => new Episode.fromJson(value)).toList();
  }

  static Map<String, Episode> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Episode>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Episode.fromJson(value));
    }
    return map;
  }
}

