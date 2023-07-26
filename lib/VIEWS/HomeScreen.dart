// ignore_for_file: implementation_imports, unnecessary_import, avoid_unnecessary_containers, unused_local_variable, dead_code, empty_statements, avoid_print, unnecessary_string_interpolations, unrelated_type_equality_checks

import 'package:beats/CONTROLLER/controller.dart';
import 'package:beats/VIEWS/PlayerScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());

    return Scaffold(
        backgroundColor: Color(0xFFF0F0F0),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/icons/search 1.png',
                width: 24,
              )),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Image.asset(
                  'assets/icons/more-vertical 1.png',
                  width: 24,
                )),
          ],
        ),
        body: FutureBuilder<List<SongModel>>(
          future: controller.audioQuery.querySongs(
              ignoreCase: true,
              orderType: OrderType.ASC_OR_SMALLER,
              sortType: null,
              uriType: UriType.EXTERNAL),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return CircularProgressIndicator();
            } else if (snapshot.data!.isEmpty) {
              return Center(child: Text('Oops ! No Data Found'));
            } else {
              print(snapshot.data);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Obx(
                          () => ListTile(
                              leading: controller.playIndex == index &&
                                      controller.isPlaying.value
                                  ? IconButton(
                                      onPressed: () {},
                                      icon: Image.asset(
                                        'assets/icons/Play.png',
                                        width: 48,
                                      ))
                                  : IconButton(
                                      onPressed: () {},
                                      icon: Image.asset(
                                        'assets/icons/Button_Play.png',
                                        width: 48,
                                      )), //Button_Play
                              title: Text(
                                '${snapshot.data![index].displayNameWOExt}',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Text(
                                '${snapshot.data![index].artist}',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              trailing: Text(controller.duration.value,
                                  style: TextStyle(
                                    fontSize: 12,
                                  )),
                              onTap: () {
                                if (controller.isPlaying.value) {
                                  Get.to(
                                      () => PlayerScreen(
                                          data: snapshot.data![index]),
                                      transition: Transition.downToUp);
                                } else {
                                  Get.to(
                                      () => PlayerScreen(
                                          data: snapshot.data![index]),
                                      transition: Transition.downToUp);
                                  controller.playSong(
                                      snapshot.data![index].uri, index);
                                }
                              }),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ));
  }
}
