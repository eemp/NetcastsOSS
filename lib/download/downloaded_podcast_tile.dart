import 'package:flutter/material.dart';

const MAX_DESCRIPTION_LEN = 150;
  
class DownloadedPodcastTile extends StatelessWidget {
  Image image;
  String subtitle;
  String title;
  int numDownloads;

  DownloadedPodcastTile({
    Key key,
    this.image,
    this.numDownloads,
    this.subtitle,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      isThreeLine: true,
      leading: Container(
        child: image,
        constraints: new BoxConstraints(maxWidth: 80.0, minWidth: 80.0),
      ),
      subtitle: Text(getDescriptionWithCount()),
      title: Text(title)
    );
  }

  T min<T extends num>(T a, T b) {
    return a < b ? a : b;
  }

  String truncatedSubtitle() {
    return this.subtitle.substring(0, min(this.subtitle.length, MAX_DESCRIPTION_LEN)).trimRight()
      + (this.subtitle.length > MAX_DESCRIPTION_LEN ? '...' : '');
  }

  String getDescriptionWithCount() {
    return this.truncatedSubtitle() + '\n' + this.numDownloads.toString() + ' episode'
      + (this.numDownloads > 1 ? 's' : '') + ' downloaded';
  }
}

