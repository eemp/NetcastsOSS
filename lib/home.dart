import 'package:flutter/material.dart';
import 'package:hear2learn/common/horizontal_list_view_card.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ListView(
        children: [
          HorizontalListViewCard(
            title: 'Your Podcasts',
            children: [
              HorizontalListTile(
                image: Image.network('https://content.production.cdn.art19.com/images/ea/bf/ce/0f/eabfce0f-4d38-4600-b5b9-3e0043b94987/e76f68f407f76ddc2b497f144e037abfe10216f49cae2716c5e174f705b1c05d83f0ff7082da9d6180d42d5a999d7979a140becf59cdc0b91aeaa0e0906793e5.jpeg'),
                title: 'Star Talk',
              ),
              HorizontalListTile(
                image: Image.network('https://content.production.cdn.art19.com/images/bd/0b/58/94/bd0b5894-05c5-42c0-910f-8f72e00006b1/e8439cdf81cbe454191c0d23ebba7e1a35e90d7cac14e411bbbd6ebf86ac3bd9d9e79f8cfcf8d07aa4b490658010044771ff51763fee14b30220509cc3a22946.jpeg'),
                title: 'The Daily Show with Trevor Noah: Ears Only Edition',
              ),
              HorizontalListTile(
                image: Image.network('https://content.production.cdn.art19.com/images/e8/49/ce/1f/e849ce1f-f43e-4e73-968e-0eca212d2ed6/5549071b8e91edc4dd373526df7cd64d6289c12808e632e2afece7e0258979c0cd5e5848a8e86eebd1e6ebeea8681ac37a23e87c01ade7584ed0bb4480997f06.jpeg'),
                title: 'The Good Place: The Podcast',
              ),
              HorizontalListTile(
                image: Image.network('https://content.production.cdn.art19.com/images/ea/bf/ce/0f/eabfce0f-4d38-4600-b5b9-3e0043b94987/e76f68f407f76ddc2b497f144e037abfe10216f49cae2716c5e174f705b1c05d83f0ff7082da9d6180d42d5a999d7979a140becf59cdc0b91aeaa0e0906793e5.jpeg'),
                title: 'Star Talk',
              ),
            ],
          ),
          HorizontalListViewCard(
            title: 'Recommendations for You',
            children: [
              HorizontalListTile(
                image: Image.network('https://content.production.cdn.art19.com/images/bd/0b/58/94/bd0b5894-05c5-42c0-910f-8f72e00006b1/e8439cdf81cbe454191c0d23ebba7e1a35e90d7cac14e411bbbd6ebf86ac3bd9d9e79f8cfcf8d07aa4b490658010044771ff51763fee14b30220509cc3a22946.jpeg'),
                title: 'The Daily Show with Trevor Noah: Ears Only Edition',
              ),
              HorizontalListTile(
                image: Image.network('https://content.production.cdn.art19.com/images/e8/49/ce/1f/e849ce1f-f43e-4e73-968e-0eca212d2ed6/5549071b8e91edc4dd373526df7cd64d6289c12808e632e2afece7e0258979c0cd5e5848a8e86eebd1e6ebeea8681ac37a23e87c01ade7584ed0bb4480997f06.jpeg'),
                title: 'The Good Place: The Podcast',
              ),
              HorizontalListTile(
                image: Image.network('https://content.production.cdn.art19.com/images/ea/bf/ce/0f/eabfce0f-4d38-4600-b5b9-3e0043b94987/e76f68f407f76ddc2b497f144e037abfe10216f49cae2716c5e174f705b1c05d83f0ff7082da9d6180d42d5a999d7979a140becf59cdc0b91aeaa0e0906793e5.jpeg'),
                title: 'Star Talk',
              ),
              HorizontalListTile(
                image: Image.network('https://content.production.cdn.art19.com/images/bd/0b/58/94/bd0b5894-05c5-42c0-910f-8f72e00006b1/e8439cdf81cbe454191c0d23ebba7e1a35e90d7cac14e411bbbd6ebf86ac3bd9d9e79f8cfcf8d07aa4b490658010044771ff51763fee14b30220509cc3a22946.jpeg'),
                title: 'The Daily Show with Trevor Noah: Ears Only Edition',
              ),
              HorizontalListTile(
                image: Image.network('https://content.production.cdn.art19.com/images/e8/49/ce/1f/e849ce1f-f43e-4e73-968e-0eca212d2ed6/5549071b8e91edc4dd373526df7cd64d6289c12808e632e2afece7e0258979c0cd5e5848a8e86eebd1e6ebeea8681ac37a23e87c01ade7584ed0bb4480997f06.jpeg'),
                title: 'The Good Place: The Podcast',
              ),
            ],
          ),
          HorizontalListViewCard(
            title: 'Trending Podcasts',
            children: [
              HorizontalListTile(
                image: Image.network('https://content.production.cdn.art19.com/images/e8/49/ce/1f/e849ce1f-f43e-4e73-968e-0eca212d2ed6/5549071b8e91edc4dd373526df7cd64d6289c12808e632e2afece7e0258979c0cd5e5848a8e86eebd1e6ebeea8681ac37a23e87c01ade7584ed0bb4480997f06.jpeg'),
                title: 'The Good Place: The Podcast',
              ),
              HorizontalListTile(
                image: Image.network('https://content.production.cdn.art19.com/images/ea/bf/ce/0f/eabfce0f-4d38-4600-b5b9-3e0043b94987/e76f68f407f76ddc2b497f144e037abfe10216f49cae2716c5e174f705b1c05d83f0ff7082da9d6180d42d5a999d7979a140becf59cdc0b91aeaa0e0906793e5.jpeg'),
                title: 'Star Talk',
              ),
              HorizontalListTile(
                image: Image.network('https://content.production.cdn.art19.com/images/bd/0b/58/94/bd0b5894-05c5-42c0-910f-8f72e00006b1/e8439cdf81cbe454191c0d23ebba7e1a35e90d7cac14e411bbbd6ebf86ac3bd9d9e79f8cfcf8d07aa4b490658010044771ff51763fee14b30220509cc3a22946.jpeg'),
                title: 'The Daily Show with Trevor Noah: Ears Only Edition',
              ),
              HorizontalListTile(
                image: Image.network('https://content.production.cdn.art19.com/images/e8/49/ce/1f/e849ce1f-f43e-4e73-968e-0eca212d2ed6/5549071b8e91edc4dd373526df7cd64d6289c12808e632e2afece7e0258979c0cd5e5848a8e86eebd1e6ebeea8681ac37a23e87c01ade7584ed0bb4480997f06.jpeg'),
                title: 'The Good Place: The Podcast',
              ),
              HorizontalListTile(
                image: Image.network('https://content.production.cdn.art19.com/images/ea/bf/ce/0f/eabfce0f-4d38-4600-b5b9-3e0043b94987/e76f68f407f76ddc2b497f144e037abfe10216f49cae2716c5e174f705b1c05d83f0ff7082da9d6180d42d5a999d7979a140becf59cdc0b91aeaa0e0906793e5.jpeg'),
                title: 'Star Talk',
              ),
              HorizontalListTile(
                image: Image.network('https://content.production.cdn.art19.com/images/bd/0b/58/94/bd0b5894-05c5-42c0-910f-8f72e00006b1/e8439cdf81cbe454191c0d23ebba7e1a35e90d7cac14e411bbbd6ebf86ac3bd9d9e79f8cfcf8d07aa4b490658010044771ff51763fee14b30220509cc3a22946.jpeg'),
                title: 'The Daily Show with Trevor Noah: Ears Only Edition',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

