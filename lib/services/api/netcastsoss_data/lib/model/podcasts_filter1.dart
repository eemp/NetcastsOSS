import 'package:jaguar_serializer/jaguar_serializer.dart';


import 'package:netcastsoss_data_api/model/podcasts_fields.dart';

part 'podcasts_filter1.jser.dart';

class PodcastsFilter1 {
  
  @Alias('offset', isNullable: false,  )
  final int offset;
  
  @Alias('limit', isNullable: false,  )
  final int limit;
  
  @Alias('skip', isNullable: false,  )
  final int skip;
  
  @Alias('order', isNullable: false,  )
  final List<String> order;
  
  @Alias('where', isNullable: false,  )
  final Map<String, Object> where;
  
  @Alias('fields', isNullable: false,  )
  final PodcastsFields fields;
  

  PodcastsFilter1(
      

{
     this.offset = null,  
     this.limit = null,  
     this.skip = null,  
     this.order = const [],  
     this.where = const {},  
     this.fields = null 
    
    }
  );

  @override
  String toString() {
    return 'PodcastsFilter1[offset=$offset, limit=$limit, skip=$skip, order=$order, where=$where, fields=$fields, ]';
  }
}

@GenSerializer(nullableFields: true)
class PodcastsFilter1Serializer extends Serializer<PodcastsFilter1> with _$PodcastsFilter1Serializer {

}

