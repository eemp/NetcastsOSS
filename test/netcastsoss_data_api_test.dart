import 'package:netcastsoss_data_api/api.dart';
import 'package:test/test.dart';


void main() {
  final jaguarApiGen = NetcastsossDataApi();
  var api_instance = jaguarApiGen.getPingControllerApi();

  test('Ping NetcastsOSS Data API', () async {
    var result = await api_instance.pingControllerPing();
    print(result);
    expect(result.greeting, equals('Hello from LoopBack'));
    expect(result.url, equals('/ping'));
  });
}

