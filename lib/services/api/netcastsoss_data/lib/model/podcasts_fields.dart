import 'package:jaguar_serializer/jaguar_serializer.dart';


part 'podcasts_fields.jser.dart';

class PodcastsFields {
  
  @Alias('id', isNullable: false,  )
  final bool id;
  
  @Alias('artist', isNullable: false,  )
  final bool artist;
  
  @Alias('artwork100', isNullable: false,  )
  final bool artwork100;
  
  @Alias('artwork30', isNullable: false,  )
  final bool artwork30;
  
  @Alias('artwork600', isNullable: false,  )
  final bool artwork600;
  
  @Alias('artwork60', isNullable: false,  )
  final bool artwork60;
  
  @Alias('artworkOrig', isNullable: false,  )
  final bool artworkOrig;
  
  @Alias('description', isNullable: false,  )
  final bool description;
  
  @Alias('episodes', isNullable: false,  )
  final bool episodes;
  
  @Alias('feed', isNullable: false,  )
  final bool feed;
  
  @Alias('genres', isNullable: false,  )
  final bool genres;
  
  @Alias('lastModifiedTimestamp', isNullable: false,  )
  final bool lastModifiedTimestamp;
  
  @Alias('lastUpdated', isNullable: false,  )
  final bool lastUpdated;
  
  @Alias('name', isNullable: false,  )
  final bool name;
  
  @Alias('popularity', isNullable: false,  )
  final bool popularity;
  
  @Alias('primaryGenre', isNullable: false,  )
  final bool primaryGenre;
  
  @Alias('releaseDate', isNullable: false,  )
  final bool releaseDate;
  
  @Alias('type', isNullable: false,  )
  final bool type;
  

  PodcastsFields(
      

{
     this.id = null,  
     this.artist = null,  
     this.artwork100 = null,  
     this.artwork30 = null,  
     this.artwork600 = null,  
     this.artwork60 = null,  
     this.artworkOrig = null,  
     this.description = null,  
     this.episodes = null,  
     this.feed = null,  
     this.genres = null,  
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
    return 'PodcastsFields[id=$id, artist=$artist, artwork100=$artwork100, artwork30=$artwork30, artwork600=$artwork600, artwork60=$artwork60, artworkOrig=$artworkOrig, description=$description, episodes=$episodes, feed=$feed, genres=$genres, lastModifiedTimestamp=$lastModifiedTimestamp, lastUpdated=$lastUpdated, name=$name, popularity=$popularity, primaryGenre=$primaryGenre, releaseDate=$releaseDate, type=$type, ]';
  }
}

@GenSerializer(nullableFields: true)
class PodcastsFieldsSerializer extends Serializer<PodcastsFields> with _$PodcastsFieldsSerializer {

}

