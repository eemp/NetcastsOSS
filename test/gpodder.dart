import 'package:swagger/api.dart';

main() async {
  var podcast_api_instance = new PodcastApi();

  var results;
  try {
      results = await podcast_api_instance.searchPodcasts('Star talk');
      print(results);
  } catch (e) {
      print("Exception when calling PetApi->addPet: $e\n");
  }
}
