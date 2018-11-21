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
            title: 'Favorites',
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
            title: 'Downloaded Podcasts',
            children: [
              HorizontalListTile(
                image: Image.network('https://content.production.cdn.art19.com/images/04/3a/fd/ae/043afdae-cf15-4bc5-8522-e0dc522f4cfc/690d7a0f71063143cd34fc294012c53e28e31cd410df0f7b99e20939237371881a55a864d7cb9db35094d8737b07bc2b92111c26e1796d203bf777049225667c.jpeg'),
                title: 'Ellen on the Go',
              ),
              HorizontalListTile(
                image: Image.network('https://content.production.cdn.art19.com/images/1d/53/8f/a0/1d538fa0-4053-481a-bc95-55b0df8d4b6a/7b5c4d189c1de41d09336dce75b6ff3be53031429822a666584b07b745c1881005b3ea8612048df9207741f9298e1d784da946fc98f373e2c8c3097694a0efc8.jpeg'),
                title: 'Dr. Death',
              ),
              HorizontalListTile(
                image: Image.network('https://content.production.cdn.art19.com/images/58/a1/cf/f4/58a1cff4-2127-476f-a386-eb043b863a7a/fb3ae239ce76e71eb5c71e73c2599b185b3afa215fec998b7e80c79a329ab63a3d722f42cba430910a265f720f33636129747921d1fb2fe0f85fcd528b2db0c5.jpeg'),
                title: 'ID10T with Chris Hardwick',
              ),
              HorizontalListTile(
                image: Image.network('https://content.production.cdn.art19.com/images/01/1b/f3/d6/011bf3d6-a448-4533-967b-e2f19e376480/ee941330897d8dc10ebc021d9c6aaf0521e8bf2257b627bfdde546723f3c9ade4a95b30a3264671c913559f88416486ac22625a9b5b661ec1e9adeb768747318.jpeg'),
                title: 'The Daily',
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

