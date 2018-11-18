part of swagger.api;

class Podcast {

  String description = null;


  String logoUrl = null;


  String mygpoLink = null;


  String scaledLogoUrl = null;


  int subscribers = null;


  int subscribersLastWeek = null;


  String title = null;


  String url = null;


  String website = null;

  Podcast();

  @override
  String toString() {
    return 'Podcast[description=$description, logoUrl=$logoUrl, mygpoLink=$mygpoLink, scaledLogoUrl=$scaledLogoUrl, subscribers=$subscribers, subscribersLastWeek=$subscribersLastWeek, title=$title, url=$url, website=$website, ]';
  }

  Podcast.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    description =
        json['description']
    ;
    logoUrl =
        json['logoUrl']
    ;
    mygpoLink =
        json['mygpoLink']
    ;
    scaledLogoUrl =
        json['scaledLogoUrl']
    ;
    subscribers =
        json['subscribers']
    ;
    subscribersLastWeek =
        json['subscribersLastWeek']
    ;
    title =
        json['title']
    ;
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
      'logoUrl': logoUrl,
      'mygpoLink': mygpoLink,
      'scaledLogoUrl': scaledLogoUrl,
      'subscribers': subscribers,
      'subscribersLastWeek': subscribersLastWeek,
      'title': title,
      'url': url,
      'website': website
     };
  }

  static List<Podcast> listFromJson(List<dynamic> json) {
    return json == null ? new List<Podcast>() : json.map((value) => new Podcast.fromJson(value)).toList();
  }

  static Map<String, Podcast> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Podcast>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Podcast.fromJson(value));
    }
    return map;
  }
}

