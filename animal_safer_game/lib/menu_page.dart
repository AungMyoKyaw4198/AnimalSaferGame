import 'package:animal_safer_game/intro_page.dart';
import 'package:animal_safer_game/ob/player_data.dart';
import 'package:animal_safer_game/settings_page.dart';
import 'package:animal_safer_game/sharePref/share_pref.dart';
import 'package:animal_safer_game/utils/game_constant.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import 'level_page.dart';

class MainMenu extends StatefulWidget {
  MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    try {
    PlayerData player = PlayerData.fromJson(await SharePref.getData("player"));
    setState(() {
      currentPlayer = player;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          // color: Color(0xffb7e7fa),
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.4),BlendMode.srcOver), 
            image: AssetImage(
              'assets/images/map/TestMap.png'
            )
          )
        ),
        child: Stack(
          children: [
            
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height -200,
                width: MediaQuery.of(context).size.width -70,
                decoration: BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: BorderRadius.vertical(top: Radius.elliptical(15, 15),bottom: Radius.elliptical(15, 15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text('Animal Safer' ,style: Theme.of(context).textTheme.headline4, textAlign: TextAlign.center,)
                  ),

                SizedBox(height: 50,),
                
                TextButton(
                  onPressed: (){
                    FlameAudio.play('click.ogg');
                    if(currentPlayer.level == 0){
                      Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (BuildContext context) => IntroPage()));
                    } else{
                      Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (BuildContext context) => LevelPage()));
                    }
                 
                }, child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset('assets/images/ui/yellow_button00.png')),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Center(child: Text('Play' ,style: Theme.of(context).textTheme.button, textAlign: TextAlign.center,))
                      )
                  ],
                )),

                TextButton(
                  onPressed: (){
                    FlameAudio.play('click.ogg');
                    Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (BuildContext context) => SettingPage()));
                    
                }, child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset('assets/images/ui/yellow_button00.png')),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Center(child: Text('Settings' ,style: Theme.of(context).textTheme.button, textAlign: TextAlign.center,))
                      )
                  ],
                ))
              ],
            ),
          ],
        )
        
      ),
    );
  }
}