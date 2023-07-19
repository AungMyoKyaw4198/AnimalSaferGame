import 'dart:math';
import 'package:animal_safer_game/components/animal.dart';
import 'package:animal_safer_game/components/rubbish.dart';
import 'package:animal_safer_game/components/world.dart';
import 'package:animal_safer_game/helpers/actions.dart';
import 'package:animal_safer_game/ob/level_ob.dart';
import 'package:animal_safer_game/provider/player_data.dart';
import 'package:animal_safer_game/utils/game_constant.dart';
import 'package:animal_safer_game/utils/level_definition.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'components/player.dart';
import 'components/world_collidable.dart';
import 'helpers/direction.dart';
import 'dart:ui';

import 'helpers/map_loader.dart';

class AnimalSaferGame extends FlameGame with HasCollidables{
  int? level;
  AnimalSaferGame({this.level});

  late Player _player;
  late World _world;
  late Animal _animal;

  late int playerscore;
  late int totalscore;
  PlayerData playerData = PlayerData();
  AssetsAudioPlayer _audioplayer = AssetsAudioPlayer();
  
  
  @override
  Future<void> onLoad() async {
    _audioplayer.open(
      Audio("assets/audio/gameplaymusic.mp3"),
      autoStart: true,
      loopMode: LoopMode.single,
      playInBackground: PlayInBackground.disabledPause,
      volume: audioVolume
    );

    checkCurrentMap();
    playerscore = 0;
    // debugMode = true;
    _world = World(name: currentMap);
    await add(_world);
    addWorldCollision();
    if(level == 0){
      _animal = Animal();
      add(_animal);
      _animal.position = Vector2(2150,900);

      _player = Player(name: currentPlayer.character,width: 50.0);
      add(_player);
      // _player.position = _world.size / 1.5;
      _player.position = Vector2(2100,900);
      // spwanRubbish();
      camera.followComponent(_player,
            worldBounds: Rect.fromLTRB(0, 0, _world.size.x, _world.size.y)); 
    
    } else{

      _player = Player(name: currentPlayer.character,width: 50.0);
      add(_player);
       _player.position = Vector2(2100,900);
      camera.followComponent(_player,
            worldBounds: Rect.fromLTRB(0, 0, _world.size.x, _world.size.y)); 
      spwanRubbish();
      addLevelConstants();
    }
    
    super.onLoad();
  }


  @override
  void update(double dt){
    super.update(dt);
    if(_player.position.x< 0){
      _player.position.x += dt * _player.playerSpeed; 
    } else if( _player.position.y< 0){
      _player.position.y += dt * _player.playerSpeed; 
    } else if(_player.position.x> _world.size.x-50){
      _player.position.x -= dt * _player.playerSpeed ; 
    }else if(_player.position.y> _world.size.y -50){
      _player.position.y -= dt * _player.playerSpeed; 
    }
  }

  checkCurrentMap(){
    if(currentPlayer.worldValue == 0.0 || currentPlayer.worldValue == 0.1){
      currentMap = 'map/AnimalSaferMap1.png';
    } else if(currentPlayer.worldValue == 0.2 || currentPlayer.worldValue == 0.3){
      currentMap = 'map/AnimalSaferMap2.png';
    } else if(currentPlayer.worldValue == 0.4 ){
      currentMap = 'map/AnimalSaferMap3.png';
    } else if(currentPlayer.worldValue == 0.5 ){
      currentMap = 'map/AnimalSaferMap4.png';
    }else if(currentPlayer.worldValue == 0.6 || currentPlayer.worldValue == 0.7){
      currentMap = 'map/AnimalSaferMap5.png';
    } else if(currentPlayer.worldValue == 0.8 || currentPlayer.worldValue == 0.9){
      currentMap = 'map/AnimalSaferMap6.png';
    } else if(currentPlayer.worldValue == 1.0){
      currentMap = 'map/AnimalSaferMap7.png';
    }
    print(currentMap);
  }

  // Control Joypad
  void onJoypadDirectionChanged(Direction direction) {
   _player.direction = direction;
  }

  // Add Collisons to the world
  void addWorldCollision() async {
    await MapLoader.readRayWorldCollisionMap().then(
      (rectList) {
        rectList.forEach(
          (rect){
             add(WorldCollidable()
            ..position = Vector2(rect.left, rect.top)
            ..width = rect.width
            ..height = rect.height
         );
          }
        );
      
     }
    );
  }

  void goToPlayer(){
    print('doing');
    while(_player.position.distanceTo(_animal.position) >60){
      _animal.animalAction = AnimalAction.walk;
      _animal.position.y += 0.3 * _player.playerSpeed; 
      print(_animal.position.y);      
    }
    _animal.animalAction = AnimalAction.none;
  }

  // When click pickup
  void onPickUp(){
    _player.playerAction = PlayerAction.pickup;

    this.children.whereType<Rubbish>().forEach((rubbish) { 
      
      if(_player.position.distanceTo(rubbish.position) <60){
        
        for(int j=0;j < levelList[level!-1].rubbishList.length; j++){

          if(levelList[level!-1].rubbishList[j].name == rubbish.name){
            FlameAudio.play('pickup.mp3');
            remove(rubbish);
            playerscore++;
            playerData.currentScore = playerscore;
          }
        }
         
      }
    });

  }

  void addLevelConstants() {
    try{
      for(var i = 0; i < levelList.length; i++){
        if(levelList[i].level == level){

          totalscore = levelList[i].totalScore;
          // currentTotalScore = levelList[i].totalScore;
          
          // Random ran = new Random();
          // for(int j=0;j < levelList[i].rubbishList.length; j++){

          //   for(int k=0;k < levelList[i].rubbishList[j].amount; k++){

          //     double locationX = ran.nextInt(3200).toDouble();
          //     double locationY= ran.nextInt(3200).toDouble();
          //     Rubbish _rubbish = Rubbish(
          //             name: levelList[i].rubbishList[j].name,
          //             width: levelList[i].rubbishList[j].width
          //           );
          //     _rubbish.position = Vector2(locationX,locationY);

          //     add(_rubbish);
          //     }
          //   }
          }
        }
      } catch(e){
        print(e);
      } 
  }

  void spwanRubbish(){
    try{

      Random ran = new Random();
      for(int j=0;j < allRubbishList.length; j++){

        for(int k=0;k < allRubbishList[j].amount; k++){

          double locationX = ran.nextInt(3200).toDouble();
          double locationY= ran.nextInt(3200).toDouble();
          Rubbish _rubbish = Rubbish(
                  name: allRubbishList[j].name,
                  width: allRubbishList[j].width
                );
          _rubbish.position = Vector2(locationX,locationY);

          add(_rubbish);
          }
        }

    } catch(e){
      print(e);
    }
  }

  void onPause(){
    pauseEngine();
  }

  void onPlay(){
    resumeEngine();
  }

  void onEnd(){
    _audioplayer.stop();
    _audioplayer.dispose();
  }

  // Generate Random Number in Range
  // int randomNumberInRange(int min, int max){
  //   final _random = new Random();
  //   return min + _random.nextInt(max - min);
  // }

  // checkRubbishCollison(double x, double y, String jsonName) async {
  //   final dynamic collisionMap = json.decode(await rootBundle.loadString(jsonName));
  //   for (final dynamic data in collisionMap['objects']){
  //     if(x <= data['x'].toDouble() && y <= data['x'].toDouble() || 
  //       x >= (data['x']+data['width']).toDouble() && y >= (data['y']+data['height']).toDouble())
  //     {
  //       return true;
  //     } 
  //   }
  // }
}