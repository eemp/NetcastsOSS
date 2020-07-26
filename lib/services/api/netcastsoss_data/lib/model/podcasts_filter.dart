import 'package:jaguar_serializer/jaguar_serializer.dart';


import 'package:netcastsoss_data_api/model/podcasts_fields.dart';

part 'podcasts_filter.jser.dart';

class PodcastsFilter {
  
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
  

  PodcastsFilter(
      

{
     this.offset = null,  
     this.limit = 10,  
     this.skip = 0,  
     this.order = const [],  
     this.where = const {},  
     this.fields = null 
    
    }
  );

  @override
  String toString() {
    // return PodcastsFilter[offset=$offset, limit=$limit, skip=$skip, order=$order, where=$where, fields=$fields, ]';
    // TODO: hack, need to serialize to JSON correctly
    return '{"limit": $limit, "skip": $skip}';
  }
}

@GenSerializer(nullableFields: true)
class PodcastsFilterSerializer extends Serializer<PodcastsFilter> with _$PodcastsFilterSerializer {

}

