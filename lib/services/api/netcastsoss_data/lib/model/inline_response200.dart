import 'package:jaguar_serializer/jaguar_serializer.dart';


import 'package:netcastsoss_data_api/model/podcasts_with_relations.dart';

part 'inline_response200.jser.dart';

class InlineResponse200 {
  
  @Alias('genre', isNullable: false,  )
  final String genre;
  
  @Alias('items', isNullable: false,  )
  final List<PodcastsWithRelations> items;
  

  InlineResponse200(
      

{
     this.genre = null,  
     this.items = const [] 
    
    }
  );

  @override
  String toString() {
    return 'InlineResponse200[genre=$genre, items=$items, ]';
  }
}

@GenSerializer(nullableFields: true)
class InlineResponse200Serializer extends Serializer<InlineResponse200> with _$InlineResponse200Serializer {

}

