import 'package:animal_safer_game/main_game_page.dart';
import 'package:animal_safer_game/menu_page.dart';
import 'package:animal_safer_game/shop_page.dart';
import 'package:animal_safer_game/utils/game_constant.dart';
import 'package:animal_safer_game/utils/level_definition.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LevelPage extends StatefulWidget {
  LevelPage({Key? key}) : super(key: key);

  @override
  _LevelPageState createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
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
                         return MainMenu();
                       })
                     );
                   },
                 ),

                 Expanded(
                   flex: 1,
                   child: Column(
                     children: [
                       Text('Welcome', style: Theme.of(context).textTheme.headline4,),
                        Text(
                          currentPlayer.name,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                     ],
                   ),
                 ),
                

                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.amber[300],
                    borderRadius: BorderRadius.circular(10)),
                  child: IconButton(
                    icon: Icon(Icons.shop_rounded),
                    iconSize: 35,
                    onPressed: (){
                      FlameAudio.play('click.ogg');
                      Navigator.of(context).pushReplacement(
                       MaterialPageRoute(builder: (BuildContext context){
                         return ShopPage();
                       })
                     );
                    },
                  ),
                )
              ],
            ),

            SizedBox(height: 10,),

            FittedBox(
                  child: Text('Choose Level',
                    style: Theme.of(context).textTheme.headline4,
                    
                  ),
                ),
            SizedBox(height: 10,),
            
            Expanded(
              // height: 300,
              child: Container(
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
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: levelList.length,
                  itemBuilder: (BuildContext ctx, index) {
                     if(currentPlayer.level >= levelList[index].level){
                       return GestureDetector(
                              onTap: (){
                                FlameAudio.play('click.ogg');
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (BuildContext context){
                                    return MainGamePage(level: levelList[index].level,);
                                  })
                                );
                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: Text('Level -'+levelList[index].level.toString()),
                                decoration: BoxDecoration(
                                    color: Colors.amber[300],
                                    borderRadius: BorderRadius.circular(15)),
                                ),
                            );
                     
                     } else{
                       return GestureDetector(
                              onTap: (){
                              },
                              child: Stack(
                                children: [
                                  
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text('Level -'+levelList[index].level.toString()),
                                    decoration: BoxDecoration(
                                        color: Colors.amber[300],
                                        borderRadius: BorderRadius.circular(15)),
                                    ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Icon(Icons.lock,
                                      size: 50,
                                      color: Colors.black87,
                                    ),
                                  )

                                ],
                              )
                            );
                     }
                     
                  }
                ),
              )
                
            ),
          ],
        ),
      ),
    );
  }
}