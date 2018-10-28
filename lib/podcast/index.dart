import 'package:flutter/material.dart';

class Podcast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Twice Removed'),
      ),
      body: ListView(
        children: [
          Container(
            child: Image.asset(
              'images/sample-podcast-main.jpg',
              fit: BoxFit.cover,
              //height: MediaQuery.of(context).size.height * 0.40,
            ),
            margin: const EdgeInsets.all(16.0),
          ),
          Container(
            child: Text(
              'A new family history podcast hosted by A.J. Jacobs.  They say we\'re one big family: this is the show that proves it.  You will be filled with delight... or abject horror.  You never know.  It\'s family.',
              softWrap: true,
              style: Theme.of(context).textTheme.body1,
            ),
            margin: const EdgeInsets.all(16.0),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // this will be set when a new tab is tapped
        fixedColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Episodes'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            title: Text('About'),
          )
        ],
      ),
    );
  }
}


