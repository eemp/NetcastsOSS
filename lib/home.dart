import 'package:flutter/material.dart';
import 'package:swagger/api.dart';

import 'package:hear2learn/common/horizontal_list_view_card.dart';
import 'package:hear2learn/subscriptions/index.dart';
import 'package:hear2learn/episode/index.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/podcast/index.dart';
import 'package:hear2learn/search/index.dart';

const MAX_SHOWCASE_LIST_SIZE = 20;

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var podcastApiService = new PodcastApi();
    var toplistFuture = podcastApiService.getTopPodcasts(MAX_SHOWCASE_LIST_SIZE, scaleLogo: 200);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ListView(
        children: [
          buildToplist(toplistFuture, title: 'Favorites'),
          buildToplist(toplistFuture),
        ],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            Container(
              child: DrawerHeader(
                child: Text('Debug Menu'),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            ListTile(
              title: Text('Homepage'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
            ),
            ListTile(
              title: Text('Your Podcasts'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubscriptionsPage()),
                );
              },
            ),
            ListTile(
              title: Text('Podcast Page'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PodcastPage(
                    url: 'http://feeds.feedburner.com/thetimferrissshow'
                    //url: 'http://feeds.feedburner.com/StartupsForTheRestOfUs'
                  )),
                );
              },
            ),
            ListTile(
              title: Text('Episode Page'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EpisodePage(
                    episode: Episode(
                      podcastTitle: 'Star Talk',
                      title: 'Technosignatures: Detecting Alien Civilizations, with David Grinspoon',
                      description: '“Is that alien club music?” asks Chuck Nice. On this episode of StarTalk All-Stars, we search for technosignatures of extraterrestrial life. Join astrobiologist and host David Grinspoon, a.k.a. Dr. FunkySpoon, comic co-host Chuck Nice, and first-time StarTalk All-Stars guest Sofia Sheikh as they investigate the process of trying to find intelligent life in the universe. Sofia is a graduate student at Penn State University specializing in SETI, radio astronomy, astrobiology, and exoplanets, and is here to help us understand the nuances of trying to find life out there. As you’ll hear, one thing that’s certain about the search for life – it asks more questions than it answers. You’ll learn how we define the differences between natural and artificial, and, if we want to look for artificial signals, what does that mean? You’ll learn if finding artificial intelligent civilizations or “alien beavers” would still be deemed a successful mission. Find out why exoplanets make the Drake equation less uncertain. Discover more about the Fermi Paradox and if alien civilizations could be strategically hiding from us. You’ll learn how much of the universe we’ve actually searched – and the answer may surprise you. Sofia explains how we search for life using radio astronomy and optical methods. You’ll find out why cell phone signals can cause headaches for researchers. You’ll also learn how to distinguish alien signals from Earth signals. We discuss the protocol that takes place in the event of receiving an alien signal and we debate if receiving a signal requires a response. You’ll explore the idea of searching for and receiving signals from ancient civilizations long gone. We ponder the idea of an ancient, technologically-advanced Earth civilization that may have been lost to the geological record, and you’ll find out if SETI is searching for exotic exhaust trails left behind by interstellar or intergalactic starships traversing the universe. All that, plus David and Sofia offer some advice to aspiring astrobiologists and astronomers.',
                    ),
                  )),
                );
              },
            ),
            ListTile(
              title: Text('Search Page'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PodcastSearch()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildToplist(Future<List<Podcast>> toplistFuture, {String title}) {
    return FutureBuilder(
      future: toplistFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Podcast>> snapshot) {
        return HorizontalListViewCard(
          title: title != null ? title : 'Top Podcasts',
          children: snapshot.hasData
            ? snapshot.data.map((podcast) =>
              HorizontalListTile(
                image: podcast.scaledLogoUrl,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PodcastPage(
                      url: podcast.url,
                    )),
                  );
                },
                title: podcast.title,
              )
            ).toList()
            : [],
        );
      },
    );
  }
}

