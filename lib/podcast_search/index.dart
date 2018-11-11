import 'package:flutter/material.dart';

class PodcastSearch extends StatelessWidget {
  final List<Map<String, dynamic>> mockData = [
    {
      'image': 'https://content.production.cdn.art19.com/images/ea/bf/ce/0f/eabfce0f-4d38-4600-b5b9-3e0043b94987/e76f68f407f76ddc2b497f144e037abfe10216f49cae2716c5e174f705b1c05d83f0ff7082da9d6180d42d5a999d7979a140becf59cdc0b91aeaa0e0906793e5.jpeg',
      'title': 'Star Talk',
    },
    {
      'image': 'https://media.npr.org/assets/img/2018/08/02/npr_planetmoney_podcasttile_sq-7b7fab0b52fd72826936c3dbe51cff94889797a0-s200-c85.jpg',
      'title': 'Planet Money',
    },
    {
      'image': 'https://media.npr.org/assets/img/2018/08/03/npr_hibt_podcasttile_sq-98320b282169a8cea04a406530e6e7b957665b3f-s200-c85.jpg',
      'title': 'How I Built This with Guy Raz',
    },
    {
      'image': 'https://media.npr.org/assets/img/2018/08/03/npr_upfirst_podcasttile_sq-9bcafe819b7297c2d92839ec8110cf5ca5fcf04f-s200-c85.jpg',
      'title': 'Up First',
    },
    {
      'image': 'https://media.npr.org/assets/img/2018/08/06/npr_wwdtm_podcasttile_sq-1e9edf5dfb49a3fff3703764e39442173ba8558a-s200-c85.jpg',
      'title': 'Wait Wait... Don\'t Tell Me',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find your next podcast'),
      ),
      body: GridView.count(
        children: List.generate(100, (index) {
          int mockIdx = (index % mockData.length).toInt();
          return Center(
            child: Column(
              children: [
                Container(
                  child: Image.network(mockData[mockIdx]['image']),
                  constraints: new BoxConstraints(maxWidth: 128.0, minWidth: 128.0),
                  padding: EdgeInsets.all(8.0),
                ),
                Container(
                  child: Text(
                    mockData[mockIdx]['title'],
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ),
              ],
            ),
          );
        }),
        crossAxisCount: 2,
      ),
    );
  }
}


