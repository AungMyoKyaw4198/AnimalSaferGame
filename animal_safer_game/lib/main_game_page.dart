import 'dart:ui';

import 'package:animal_safer_game/animal_safer_game.dart';
import 'package:animal_safer_game/bloc/game_bloc.dart';
import 'package:animal_safer_game/level_page.dart';
import 'package:animal_safer_game/ob/level_ob.dart';
import 'package:animal_safer_game/ob/response_ob.dart';
import 'package:animal_safer_game/provider/player_data.dart';
import 'package:animal_safer_game/sharePref/share_pref.dart';
import 'package:animal_safer_game/utils/game_constant.dart';
import 'package:animal_safer_game/utils/level_definition.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'helpers/direction.dart';
import 'helpers/joypad.dart';
import 'helpers/pick_button.dart';

class MainGamePage extends StatefulWidget {
  final int level;
  const MainGamePage({Key? key, required this.level}) : super(key: key);

  @override
  MainGameState createState() => MainGameState();
}

class MainGameState extends State<MainGamePage> {
  late AnimalSaferGame game;
  GameBloc _gameBloc = GameBloc();
  late LevelOb currentLevel;
  late RubbishType currentRubbish;
  List<RubbishType> currentRubbishList = [];

  @override
  void initState() {
    print(widget.level);
    game = AnimalSaferGame(level: widget.level);
    currentLevel = levelList[widget.level-1];
    currentRubbishList = currentLevel.rubbishList;
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
        backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
        body: StreamBuilder<ReponseOb>(
          initialData: ReponseOb(gameState: GameState.start),
          stream: _gameBloc.getControllerStream(),
          builder: (BuildContext context, AsyncSnapshot<ReponseOb> snapshot){
            ReponseOb responseOb= snapshot.data!;

            if(responseOb.gameState == GameState.start){
              return Stack(
                children: [
                  GameWidget(
                    loadingBuilder: (context){
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/images/map/backgroundForest.png'
                            )
                          )
                        ),
                        child: Text('L O A D I N G........',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      );
                    },
                    game: game
                  ),

                  Center(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Card(
                        shape:
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        color: Colors.black.withAlpha(100),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height -300,
                          width: MediaQuery.of(context).size.width -100,
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Text('GAME OBJECTIVES',style: TextStyle(color: Colors.white), ),
                              SizedBox(height: 50,),
                              Text('Search and collect items', style: TextStyle(color: Colors.white60),),
                              SizedBox(height: 50,),
                              Flexible(
                                child: GridView.builder(
                                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      childAspectRatio: 3 / 2,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20),
                                  itemCount: currentRubbishList.length,
                                  itemBuilder: (BuildContext ctx, index) {
                            
                                    return Row(
                                      children: [
                                        Image.asset('assets/images/'+currentRubbishList[index].name, width: 30,height: 30,),
                                        Text('  *'+ currentRubbishList[index].amount.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20
                                          ),
                                        )
                                      ],
                                    );
                                  }
                                ),
                              ),
                              

                              SizedBox(height: 50,),
                              TextButton(onPressed: (){
                                onResume();
                              }, child: Text('START'))
                            ],
                          )
                        ),
                      )
                    )
                  ),

                ],
              );
            } 

            else if(responseOb.gameState == GameState.resume){
              return Stack(
                children: [

                  GameWidget(
                    game: game),

                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.pause),
                      onPressed: (){

                        onPause();
                      },
                    ),
                  ),

                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('SEEDS : '),
                          ChangeNotifierProvider.value(
                            value: game.playerData,
                            child: Selector<PlayerData, int>(
                              selector: (_, playerData) => playerData.currentScore,
                              builder: (_, score, __) {
                                if(score == game.totalscore){
                                  onFinished();
                                }
                                return Text(
                                  '$score',
                                  // style: const TextStyle(fontSize: 20,),
                                );
                              },
                            ),
                          ),
                          Text(' / '),
                          Text(game.totalscore.toString()),
                        ],),
                    )
                  ),
                  

                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Joypad(onDirectionChanged: onJoypadDirectionChanged),
                    ),
                  ),


                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: SizedBox(
                        height: 120,
                        width: 120,
                        child: GestureDetector(
                          onTap: (){
                            onPickUp();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color(0x88ffffff),

                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: Center(
                              child: Text('Pick Up'),)
                          ),
                        
                        ),
                      ),
                    ),
                  )
                ],
              );
            }

            else if(responseOb.gameState == GameState.pause){
              return Stack(
                children: [
                   GameWidget(game: game),

                  Center(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Card(
                        shape:
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        color: Colors.black.withAlpha(100),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height -300,
                          width: MediaQuery.of(context).size.width -100,
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Text('PAUSE MENU',style: TextStyle(color: Colors.white),  ),
                              SizedBox(height: 30,),
                              Text('GAME OBJECTIVES',style: TextStyle(color: Colors.white), ),
                              SizedBox(height: 50,),
                              Text('Search and collect items', style: TextStyle(color: Colors.white60),),
                              SizedBox(height: 50,),
                              Flexible(
                                child: GridView.builder(
                                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      childAspectRatio: 3 / 2,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20),
                                  itemCount: currentRubbishList.length,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return Row(
                                      children: [
                                        Image.asset('assets/images/'+currentRubbishList[index].name, width: 30,height: 30,),
                                        Text('  *'+ currentRubbishList[index].amount.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20
                                          ),
                                        )
                                      ],
                                    );
                                  }
                                ),
                              ),

                              TextButton(onPressed: (){
                                onResume();
                              }, child: Text('RESUME')),

                              TextButton(onPressed: (){
                                Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (BuildContext context) => LevelPage()));
                              }, child: Text('BACK'))
                            ],
                          )
                        ),
                      )
                    )
                  ),

                ],
              );
            }

            else if(responseOb.gameState == GameState.finished){
              return Stack(
                children: [
                   GameWidget(game: game),

                  Center(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Card(
                        shape:
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        color: Colors.black.withAlpha(100),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height -300,
                          width: MediaQuery.of(context).size.width -100,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('LEVEL COMPLETED!' ,style: TextStyle(color: Colors.amber,fontSize: 20),),

                              Text('You Collected' ,style: TextStyle(color: Colors.white,fontSize: 20),),

                              Text(game.playerData.currentScore.toString()+' SEEDS' ,style: TextStyle(color: Colors.green,fontSize: 20),),
                              
                              TextButton(
                                onPressed: (){
                                 currentPlayer.currentScore += game.playerData.currentScore;
                                 if(currentPlayer.level <= widget.level){
                                   currentPlayer.level = widget.level +1;
                                 }
                                 print(currentPlayer.level);

                                 SharePref.saveData('player',currentPlayer);

                                 Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (BuildContext context){
                                    return LevelPage();
                                  })
                                );
                              }, child: Text('Next Level'))
                            ],
                          )
                        ),
                      )
                    )
                  ),

                ],
              );
            }

            else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }

                }
              )
              
        
        
        
        );
  }

  void onJoypadDirectionChanged(Direction direction) {
    game.onJoypadDirectionChanged(direction);
  }

  void onPickUp(){
    game.onPickUp();
  }

  void onStart(){
    _gameBloc.startGame();
  }

  void onPause(){
    _gameBloc.pauseGame();
    // if(isPaused){
    //   game.onPause();
    // }else{
    //   game.onPlay();
    // }
  }

  void onResume(){
    _gameBloc.resumeGame();
  }

  void onFinished(){
    _gameBloc.finishedGame();
  }

  void onRestart(){

  }

}
