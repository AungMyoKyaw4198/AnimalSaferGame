import 'dart:ui';

import 'package:animal_safer_game/animal_safer_game.dart';
import 'package:animal_safer_game/enter_name_page.dart';
import 'package:animal_safer_game/level_page.dart';
import 'package:animal_safer_game/menu_page.dart';
import 'package:animal_safer_game/utils/game_constant.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  AnimalSaferGame game = AnimalSaferGame(level: 0);
  
  int currentIndex = 0;
  String currentText = '';
  bool dialogFinished = false;

  @override
  void initState() {
    currentText = dialogText[currentIndex];
    dialogFinished = false;
    super.initState();
  }

  @override
  void dispose() {
    game.onEnd();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(
            loadingBuilder: (context){
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xffb7e7fa)
                ),
                child: Text('L O A D I N G........',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
              );
            },
            game: game
            ),

          // Align(
          //   alignment: Alignment.topRight,
          //   child: TextButton(
          //     child: Text('Next'),
          //     onPressed: (){
          //       Navigator.pushReplacement(
          //           context, MaterialPageRoute(builder: (BuildContext context) => LevelPage()));
          //     },
          //   ),
          // ),

          // Align(
          //   alignment: Alignment.topLeft,
          //   child: TextButton(
          //     child: Text('Back'),
          //     onPressed: (){
          //       Navigator.pushReplacement(
          //           context, MaterialPageRoute(builder: (BuildContext context) => MainMenu()));
          //     },
          //   ),
          // ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 10,left: 5,right: 5),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.vertical(top: Radius.elliptical(15, 15),bottom: Radius.elliptical(15, 15)),
              ),
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Column(
                children: [
                  Text(currentText, style: TextStyle(color: Colors.white),),

                  SizedBox(height: 20,),
                  
                  dialogFinished? 
                    TextButton(onPressed: (){
                      FlameAudio.play('click.ogg');
                      Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (BuildContext context) => EnterNamePage()));
                    }, child: Text('Start'))
                  : TextButton(onPressed: (){
                    FlameAudio.play('click.ogg');
                    
                    setState(() {
                      currentIndex++;
                      currentText = dialogText[currentIndex];
                      if(currentIndex == 10){
                        setState(() {
                          dialogFinished = true;
                        });
                      }
                    });
                  }, child: Text('Next'))
                ],
              )
            ),
          ),

        ],
      ),
    );
  }
}