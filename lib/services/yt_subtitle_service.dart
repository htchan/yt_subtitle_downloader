import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YtSubtitleService {
  static YoutubeExplode yt = YoutubeExplode();
  Future<ClosedCaptionManifest>? trackManifest;
  Set<String> languages = {};

  YtSubtitleService(String link) {
    var videoId = Uri.parse(link).queryParameters['v'];
    trackManifest = yt.videos.closedCaptions.getManifest(videoId);
  }

  Future<Set<String>> get availableLanguages async{
    if ((trackManifest == null) || (languages.isNotEmpty)) {
      return languages;
    }

    var manifest = await trackManifest;
    return manifest!.tracks.map((track) => track.language.code).toSet();
  }

  Future<String> subtitles(String language) async {
    if (trackManifest == null) {
      return "";
    }
    
    var manifest = await trackManifest;
    var trackInfo = manifest!.getByLanguage(language)[0];
    var captions = await yt.videos.closedCaptions.get(trackInfo);
    return captions.captions.map((caption) => caption.text).join(" ");
  }
}
