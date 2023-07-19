import 'dart:math';

import 'package:animal_safer_game/animal_safer_game.dart';
import 'package:animal_safer_game/level_page.dart';
import 'package:animal_safer_game/sharePref/share_pref.dart';
import 'package:animal_safer_game/utils/game_constant.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';


class ShopPage extends StatefulWidget {
  ShopPage({Key? key}) : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  AnimalSaferGame game = AnimalSaferGame();
  String currCharacter = 'assets/images/characters/faces/adventurer.png';
  bool isClean = false;
  double number = 0.0;
  double addNumber = 1.0;
  

  @override
  void initState() {
    if(currentPlayer.worldValue == 1.0){
      setState(() {
        isClean = true;
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    
    SharePref.saveData('player',currentPlayer);
    super.dispose();
  }

  updateProgress() {  
    // const oneSec = const Duration(seconds: 3);     
    // _timer = new periodic(3.0,
    // (timer){
      
    // }
    // );
    // Timer.periodic(oneSec, (Timer t) {  
    //   setState(() {  
    //     _currValue += 0.1;  
    //     // we "finish" downloading here  
    //     if (_currValue.toString() == _worldValue.toString()) {  
    //       _loading = false;  
    //       t.cancel();  
    //       return;  
    //     }  
    //   });  
    // });  
  }  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4),BlendMode.srcOver), 
            image: AssetImage(
              'assets/images/map/TestMap.png'
            )
          )
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 IconButton(
                   icon: Image.asset('assets/images/ui/yellow_sliderLeft.png',height: 50,width: 50,),
                   onPressed: (){
                     FlameAudio.play('click.ogg');
                     Navigator.of(context).pushReplacement(
                       MaterialPageRoute(builder: (BuildContext context){
                         return LevelPage();
                       })
                     );
                   },
                 ),

                  // TextButton(onPressed: (){
                  //     setState(() {
                  //       currentPlayer.currentScore = 0;
                  //         currentPlayer.worldValue = 0.0;
                  //       });
                  //   }, child: Text('Reset'))

              ],
            ),

            FittedBox(
                  child: Text('SHOP',
                    style: Theme.of(context).textTheme.headline4,
                    
                  ),
                ),
            SizedBox(height: 5,),

            Expanded(
              flex: 2,
              child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FittedBox(
                        child: Text('SELECT CHARACTER',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                      
                      SizedBox(height: 10,),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                          itemCount: characterFacesList.length,
                          itemBuilder: (BuildContext ctx, index) {
                            if(currentPlayer.characterFace == characterFacesList[index]){
                              return GestureDetector(
                                onTap: (){
                                  FlameAudio.play('click.ogg');
                                  String name1 = characterFacesList[index].substring(31,characterFacesList[index].length-4);
                                  currentPlayer.characterFace = characterFacesList[index];
                                  currentPlayer.character = 'characters/'+name1+'_spritesheet.png';
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black38,
                                    border: Border.all(color: Colors.white,width: 4),
                                    borderRadius: BorderRadius.vertical(top: Radius.elliptical(15, 15),bottom: Radius.elliptical(15, 15)),
                                    ),
                                  width: 70,
                                  height: 70,
                                  child: Image.asset(characterFacesList[index],)
                                ),
                              );
                            } 
                            return GestureDetector(
                              onTap: (){
                                FlameAudio.play('click.ogg');
                                setState(() {
                                    currCharacter = characterFacesList[index];
                                    String name1 = characterFacesList[index].substring(31,characterFacesList[index].length-4);
                                    currentPlayer.characterFace = characterFacesList[index];
                                    currentPlayer.character = 'characters/'+name1+'_spritesheet.png';
                                  });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.vertical(top: Radius.elliptical(15, 15),bottom: Radius.elliptical(15, 15)),
                                  ),
                                width: 70,
                                height: 70,
                                child: Image.asset(characterFacesList[index])
                              ),
                            );
                          }
                        ),
                      ),

                      
                    ],
                  ),
              ),
            ),

            SizedBox(height: 20,),

            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                  padding: EdgeInsets.all(10),
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
                child: Column(
                  children: [
                    Text('Level   :    ${currentPlayer.level}'),
                    Text('SEED Collected   :    ${currentPlayer.currentScore}'),

                    SizedBox(height: 20,),
                     
                    isClean? Text('The World is Clean !')
                      :Text('${100- currentPlayer.worldValue *100 }%  left  to  Renew'),
                    
                    LinearProgressIndicator(
                      minHeight: 30,
                      value: currentPlayer.worldValue,
                      backgroundColor: Colors.black45,  
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),  
                    ),

                    SizedBox(height: 10,),
                    TextButton(
                      onPressed: (){
                        FlameAudio.play('click.ogg');
                        // calculateUserScore();
                        if(calculateUserScore() && !isClean){
                          setState(() {
                            print(currentPlayer.worldValue);
                            if(currentPlayer.worldValue != 1.0){
                              number += addNumber;
                              print(number);
                              currentPlayer.worldValue = roundDouble(number, 1);
                              if(currentPlayer.worldValue == 1.0){
                                setState(() {
                                  isClean = true;
                                });
                              }
                            }
                        });
                        }
                        
                      }, 
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset('assets/images/ui/green_button00.png')),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Center(child: Text('RENEW' ,style: Theme.of(context).textTheme.button, textAlign: TextAlign.center,))
                          )
                      ],
                    )),

                  ],
                ),
              ),
            )
            
          ],
        ),
      ),
    );
  }

  double roundDouble(double value, int places){ 
    num mod = pow(10.0, places); 
    return ((value * mod).round().toDouble() / mod); 
  }

  calculateUserScore(){
    if(currentPlayer.currentScore % 11 == 0 && currentPlayer.currentScore != 0 && currentPlayer.currentScore <= 110){
      setState(() {
        addNumber = (currentPlayer.currentScore/11) *0.1;
        currentPlayer.currentScore = currentPlayer.currentScore - (addNumber * 110).round();
      });
      return true;
    }
    return false;
  }
}