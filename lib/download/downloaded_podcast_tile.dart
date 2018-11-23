import 'package:flutter/material.dart';

const MAX_DESCRIPTION_LEN = 150;
  
class DownloadedPodcastTile extends StatelessWidget {
  Image image;
  String subtitle;
  String title;
  int numDownloads;
  double imageSize = 80.0;

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
      contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      leading: Container(
        child: image,
        constraints: new BoxConstraints(maxWidth: imageSize, minWidth: imageSize),
      ),
      subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            new Flexible(
              child: Text(
                this.subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontStyle: FontStyle.italic),
              )
            ),
            Text(
              this.numDownloads.toString() + ' episode' + (this.numDownloads > 1 ? 's' : '') + ' downloaded',
              maxLines: 1,
            )
          ],
        ),
      title: Text(title)
    );
  }
}

