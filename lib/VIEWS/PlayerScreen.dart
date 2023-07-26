// ignore_for_file: implementation_imports, unnecessary_import, avoid_unnecessary_containers, unused_local_variable, dead_code, empty_statements, avoid_print, unnecessary_string_interpolations, unrelated_type_equality_checks, prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:beats/CONTROLLER/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerScreen extends StatefulWidget {
  final SongModel data;
  const PlayerScreen({super.key, required this.data});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
            size: 16,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          children: [
            Text(
              'Now Playing',
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              'Wegz',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFFF0F0F0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image(
            image: AssetImage('assets/icons/wegz.jpg'),
            width: 250,
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Text('${widget.data.displayNameWOExt}'),
              Text('${widget.data.artist}'),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Slider(
                            value: controller.value.value,
                            min: Duration(seconds: 0).inSeconds.toDouble(),
                            max: controller.max.value,
                            activeColor: Color(0xFF5C42FF),
                            inactiveColor: Color(0xffE0E0E0),
                            onChanged: (newValue) {
                              controller.changeDuration(newValue.toInt());
                              newValue = newValue;
                            }),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(controller.position.value),
                      Text(controller.duration.value),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  controller.audioPlayer.seekToPrevious();
                },
                child: Image(
                  image: AssetImage(
                    'assets/icons/Playback.png',
                  ),
                  width: 45,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Obx(
                () => InkWell(
                  onTap: () {
                    if (controller.isPlaying.value) {
                      controller.audioPlayer.pause();
                      controller.isPlaying(false);
                    } else {
                      controller.audioPlayer.play();
                      controller.isPlaying(true);
                    }
                  },
                  child: Container(
                    child: controller.isPlaying.value
                        ? Image(
                            image: AssetImage(
                              'assets/icons/Play.png',
                            ),
                            width: 80,
                          )
                        : Image(
                            image: AssetImage(
                              'assets/icons/Button_Play.png',
                            ),
                            width: 80,
                          ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  controller.audioPlayer.setLoopMode(LoopMode.all);
                },
                child: Image(
                  image: AssetImage(
                    'assets/icons/Next.png',
                  ),
                  width: 45,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 80,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(80),
                    topLeft: Radius.circular(80))),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/icons/chevron-up 1.png',
                      width: 24,
                    )),
                Text('LYRICS')
              ],
            ),
          )
        ],
      ),
    );
  }
}
