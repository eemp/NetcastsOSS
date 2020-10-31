import 'package:jaguar_serializer/jaguar_serializer.dart';


part 'podcasts.jser.dart';

class Podcasts {
  
  @Alias('id', isNullable: false,  )
  final String id;
  
  @Alias('artist', isNullable: false,  )
  final String artist;
  
  @Alias('artwork100', isNullable: false,  )
  final String artwork100;
  
  @Alias('artwork30', isNullable: false,  )
  final String artwork30;
  
  @Alias('artwork600', isNullable: false,  )
  final String artwork600;
  
  @Alias('artwork60', isNullable: false,  )
  final String artwork60;
  
  @Alias('artworkOrig', isNullable: false,  )
  final String artworkOrig;
  
  @Alias('description', isNullable: false,  )
  final String description;
  
  @Alias('episodes', isNullable: false,  )
  final String episodes;
  
  @Alias('feed', isNullable: false,  )
  final String feed;
  
  @Alias('genres', isNullable: false,  )
  final String genres;
  
  @Alias('lastModifiedTimestamp', isNullable: false,  )
  final DateTime lastModifiedTimestamp;
  
  @Alias('lastUpdated', isNullable: false,  )
  final DateTime lastUpdated;
  
  @Alias('name', isNullable: false,  )
  final String name;
  
  @Alias('popularity', isNullable: false,  )
  final num popularity;
  
  @Alias('primaryGenre', isNullable: false,  )
  final String primaryGenre;
  
  @Alias('releaseDate', isNullable: false,  )
  final DateTime releaseDate;
  
  @Alias('type', isNullable: false,  )
  final String type;
  

  Podcasts(
      

{
    
     this.id = null,   this.artist = null,  
     this.artwork100 = null,  
     this.artwork30 = null,  
     this.artwork600 = null,  
     this.artwork60 = null,  
     this.artworkOrig = null,  
     this.description = null,  
     this.episodes = null,  
    
     this.feed = null,   this.genres = null,  
     this.lastModifiedTimestamp = null,  
     this.lastUpdated = null,  
     this.name = null,  
     this.popularity = null,  
     this.primaryGenre = null,  
     this.releaseDate = null,  
     this.type = null 
    
    }
  );

  @override
  String toString() {
    return 'Podcasts[id=$id, artist=$artist, artwork100=$artwork100, artwork30=$artwork30, artwork600=$artwork600, artwork60=$artwork60, artworkOrig=$artworkOrig, description=$description, episodes=$episodes, feed=$feed, genres=$genres, lastModifiedTimestamp=$lastModifiedTimestamp, lastUpdated=$lastUpdated, name=$name, popularity=$popularity, primaryGenre=$primaryGenre, releaseDate=$releaseDate, type=$type, ]';
  }
}

@GenSerializer(nullableFields: true)
class PodcastsSerializer extends Serializer<Podcasts> with _$PodcastsSerializer {

}

