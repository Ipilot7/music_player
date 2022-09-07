import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:solid/utils/custom_textstyle.dart';

import 'utils/colors.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class PlayingNow extends StatefulWidget {
  const PlayingNow({super.key, required this.songModel});
  final SongModel songModel;

  @override
  State<PlayingNow> createState() => _PlayingNowState();
}

class _PlayingNowState extends State<PlayingNow> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  IconData playBtn = Icons.play_arrow;
  bool playing = false;
  int rating = 30;

  Duration position = const Duration();
  Duration musicLength = const Duration();

  @override
  void initState() {
    super.initState();
    playSong();
  }

  playSong() {
    try {
      _audioPlayer
          .setAudioSource(AudioSource.uri(Uri.parse(widget.songModel.uri!)));
      _audioPlayer.play();
      playing = true;
    } on Exception {
      log('Cannot Parse song');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.keyboard_backspace,
                          color: AppColors.textColor,
                          size: 30,
                        ),
                      ),
                    ),
                    Text(
                      'Playing Now',
                      style: kTextstyle(size: 20),
                    ),
                    Container()
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 350, bottom: 55),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Column(
                        children: [
                          Text(
                            widget.songModel.displayNameWOExt,
                            style: kTextstyle(size: 24),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.songModel.artist.toString(),
                            style: kTextstyle(
                                size: 16, color: AppColors.subtitleColor),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.favorite_outline,
                        color: AppColors.subtitleColor,
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.volume_down_outlined,
                        color: AppColors.playingColor),
                    const Spacer(),
                    Icon(Icons.sync, color: AppColors.playingColor),
                    const SizedBox(width: 20),
                    Icon(Icons.shuffle, color: AppColors.playingColor)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 64),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${position.inMinutes}:${position.inSeconds}',
                          style: kTextstyle(color: AppColors.playingColor)),
                      Text(
                          '${musicLength.inMinutes}:${musicLength.inSeconds.remainder(60)}',
                          style: kTextstyle(color: AppColors.playingColor))
                    ],
                  ),
                ),
                Slider(
                  inactiveColor: AppColors.playingColor,
                  label: "Select Age",
                  value: rating.toDouble(),
                  onChanged: (value) async {},
                  min: 0,
                  max: 100,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.skip_previous,
                            color: AppColors.textColor, size: 40),
                      ),
                      IconButton(
                        onPressed: () {
                          if (playing) {
                            _audioPlayer.pause();
                          } else {
                            _audioPlayer.play();
                          }
                          setState(() {
                            playing = !playing;
                          });
                        },
                        icon: Icon(playing ? Icons.pause : playBtn,
                            color: AppColors.textColor, size: 40),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.skip_next,
                            color: AppColors.textColor, size: 40),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            child: CarouselSlider(
              options: CarouselOptions(
                  aspectRatio: 2 / 2.5,
                  scrollPhysics: const BouncingScrollPhysics(),
                  enlargeCenterPage: true),
              items: imgList
                  .map((item) => Center(
                          child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child:
                            Image.network(item, fit: BoxFit.cover, width: 1000),
                      )))
                  .toList(),
            ),
          )
        ]),
      ),
    );
  }
}
