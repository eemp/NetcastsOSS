import 'package:jaguar_serializer/jaguar_serializer.dart';


part 'loopback_count.jser.dart';

class LoopbackCount {
  
  @Alias('count', isNullable: false,  )
  final num count;
  

  LoopbackCount(
      

{
     this.count = null 
    
    }
  );

  @override
  String toString() {
    return 'LoopbackCount[count=$count, ]';
  }
}

@GenSerializer(nullableFields: true)
class LoopbackCountSerializer extends Serializer<LoopbackCount> with _$LoopbackCountSerializer {

}

