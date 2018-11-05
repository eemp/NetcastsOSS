import 'package:flutter/material.dart';

import 'package:hear2learn/common/people.dart';
import 'package:hear2learn/common/tags.dart';

class EpisodeInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          child: Text('People', style: Theme.of(context).textTheme.subhead),
          margin: const EdgeInsets.only(bottom: 16.0),
        ),
        Container(
          child: PeopleList(),
          margin: const EdgeInsets.only(bottom: 16.0),
        ),
        Container(
          child: Text('Description', style: Theme.of(context).textTheme.subhead),
          margin: const EdgeInsets.only(bottom: 16.0),
        ),
        Container(
          child: Text(
            '“Is that alien club music?” asks Chuck Nice. On this episode of StarTalk All-Stars, we search for technosignatures of extraterrestrial life. Join astrobiologist and host David Grinspoon, a.k.a. Dr. FunkySpoon, comic co-host Chuck Nice, and first-time StarTalk All-Stars guest Sofia Sheikh as they investigate the process of trying to find intelligent life in the universe. Sofia is a graduate student at Penn State University specializing in SETI, radio astronomy, astrobiology, and exoplanets, and is here to help us understand the nuances of trying to find life out there. As you’ll hear, one thing that’s certain about the search for life – it asks more questions than it answers. You’ll learn how we define the differences between natural and artificial, and, if we want to look for artificial signals, what does that mean? You’ll learn if finding artificial intelligent civilizations or “alien beavers” would still be deemed a successful mission. Find out why exoplanets make the Drake equation less uncertain. Discover more about the Fermi Paradox and if alien civilizations could be strategically hiding from us. You’ll learn how much of the universe we’ve actually searched – and the answer may surprise you. Sofia explains how we search for life using radio astronomy and optical methods. You’ll find out why cell phone signals can cause headaches for researchers. You’ll also learn how to distinguish alien signals from Earth signals. We discuss the protocol that takes place in the event of receiving an alien signal and we debate if receiving a signal requires a response. You’ll explore the idea of searching for and receiving signals from ancient civilizations long gone. We ponder the idea of an ancient, technologically-advanced Earth civilization that may have been lost to the geological record, and you’ll find out if SETI is searching for exotic exhaust trails left behind by interstellar or intergalactic starships traversing the universe. All that, plus David and Sofia offer some advice to aspiring astrobiologists and astronomers.',
            softWrap: true,
            style: Theme.of(context).textTheme.body1,
          ),
          padding: EdgeInsets.only(bottom: 16.0),
        ),
        Container(
          child: Text('Topics', style: Theme.of(context).textTheme.subhead),
          margin: const EdgeInsets.only(bottom: 16.0),
        ),
        Container(
          child: Tags(),
          margin: const EdgeInsets.only(bottom: 16.0),
        ),
      ],
    );
  }
}
