import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class ListMusicFromStorage extends StatefulWidget {
  const ListMusicFromStorage({super.key});

  @override
  State<ListMusicFromStorage> createState() => _ListMusicFromStorageState();
}

class _ListMusicFromStorageState extends State<ListMusicFromStorage> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final AudioPlayer _audioPlayer = AudioPlayer();
  @override
  void initState() {
    super.initState();
    Permission.storage.request();
  }

  playSong(String? uri) {
    try {
      _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
    } on Exception {
      log('Error parsing');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('data'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: FutureBuilder<List<SongModel>>(
        future: _audioQuery.querySongs(
            sortType: null,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            ignoreCase: true),
        builder: (context, item) {
          if (item.data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (item.data!.isEmpty) {
            return const Center(
              child: Text('Nothing found'),
            );
          } else {
            return ListView.builder(
                itemCount: item.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(item.data![index].title),
                    subtitle: Text(item.data![index].artist ?? 'No name'),
                    trailing: const Icon(Icons.more_horiz),
                    leading: const CircleAvatar(child: Icon(Icons.music_note)),
                    onTap: () {
                      playSong(item.data![index].uri);
                    },
                  );
                });
          }
        },
      ),
    );
  }
}
