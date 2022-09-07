import 'package:flutter/material.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class AllSong extends StatefulWidget {
  const AllSong({super.key});

  @override
  State<AllSong> createState() => _AllSongState();
}

class _AllSongState extends State<AllSong> {
  @override
  void initState() {
    super.initState();
    requetsPermission();
  }

  void requetsPermission() {
    Permission.storage.request();
  }

  final _audioQuery = OnAudioQuery();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Player'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: FutureBuilder<List<SongModel>>(
        future: _audioQuery.querySongs(
            sortType: null,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            ignoreCase: true),
        builder: ((context, item) {
          if (item.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (item.data!.isEmpty) {
            return const Center(child: Text('No Songs found'));
          }
          return ListView.builder(
              itemCount: item.data!.length,
              itemBuilder: (context, index) => ListTile(
                    leading: const Icon(Icons.music_note),
                    title: Text(item.data![index].displayNameWOExt),
                    subtitle: Text('${item.data![index].artist}'),
                    trailing: const Icon(Icons.more_horiz),
                  ));
        }),
      ),
    );
  }
}
