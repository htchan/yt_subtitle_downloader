import 'package:flutter/material.dart';
import 'package:yt_subtitle_downloader/services/yt_subtitle_service.dart';

class Querier extends StatefulWidget {
  Function(String) updateSubtitle;
  Querier({super.key, required this.updateSubtitle});

  @override
  State<Querier> createState() => _QuerierState();
}

class _QuerierState extends State<Querier> {
  TextEditingController linkController = TextEditingController();
  YtSubtitleService? service;
  Set<String> availableLanguages = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: linkController,
          decoration: const InputDecoration.collapsed(hintText: 'YT link'),
        ),
        IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              service = YtSubtitleService(linkController.text);
              availableLanguages = await service!.availableLanguages;
              setState(() {
                this.service = service;
                this.availableLanguages = availableLanguages;
              });
            }),
        DropdownButton<String>(
            items: availableLanguages
                .map((lang) => DropdownMenuItem<String>(
                      child: Text(lang),
                      value: lang,
                    ))
                .toList(),
            onChanged: (value) async {
              if (value == null) {
                return;
              }
              widget.updateSubtitle(await service!.subtitles(value));
            }),
      ],
    );
  }
}
