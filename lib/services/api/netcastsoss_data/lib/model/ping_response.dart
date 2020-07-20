import 'package:jaguar_serializer/jaguar_serializer.dart';


part 'ping_response.jser.dart';

class PingResponse {
  
  @Alias('greeting', isNullable: false,  )
  final String greeting;
  
  @Alias('date', isNullable: false,  )
  final String date;
  
  @Alias('url', isNullable: false,  )
  final String url;
  
  @Alias('headers', isNullable: false,  )
  final Map<String, Object> headers;
  

  PingResponse(
      

{
     this.greeting = null,  
     this.date = null,  
     this.url = null,  
     this.headers = const {} 
    
    }
  );

  @override
  String toString() {
    return 'PingResponse[greeting=$greeting, date=$date, url=$url, headers=$headers, ]';
  }
}

@GenSerializer(nullableFields: true)
class PingResponseSerializer extends Serializer<PingResponse> with _$PingResponseSerializer {

}

