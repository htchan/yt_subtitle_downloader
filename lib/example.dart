// ignore_for_file: avoid_print
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

Future<void> main() async {
  var yt = YoutubeExplode();
  var trackManifest = await yt.videos.closedCaptions.getManifest('ts9rG0XCHAM');

print("tracks: ${trackManifest.tracks[0]}");
  var trackInfo = trackManifest.getByLanguage('zh-TW');
print("track info: ${trackInfo}");
var captions = await yt.videos.closedCaptions.get(trackInfo[0]);
print("caption: ${captions}");

// print(captions.captions);

var finalResult = captions.captions.map((e) => e.text).join(" ");
print(finalResult);
// var subtitle = await yt.videos.closedCaptions.getSubTitles(trackInfo[0]);

// print("subtitles: ${subtitle}");
  // Close the YoutubeExplode's http client.
  yt.close();
}