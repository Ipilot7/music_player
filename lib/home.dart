import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:solid/playing_now.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final AudioPlayer _audioPlayer = AudioPlayer();
  @override
  void initState() {
    super.initState();
    Permission.storage.request();
  }



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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => PlayingNow(songModel: item.data![index],)));
                    },
                  );
                });
          }
        },
      ),
    );
  }
}
