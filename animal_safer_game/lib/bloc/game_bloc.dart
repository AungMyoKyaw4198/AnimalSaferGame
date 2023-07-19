import 'dart:async';

import 'package:animal_safer_game/animal_safer_game.dart';
import 'package:animal_safer_game/ob/response_ob.dart';

class GameBloc{
  AnimalSaferGame game = AnimalSaferGame();
  
  StreamController<ReponseOb> _responseController = StreamController<ReponseOb>();

  // get methods
  Stream<ReponseOb> getControllerStream() => _responseController.stream;



  dispose() {
    _responseController.close();
  }

  startGame(){
    ReponseOb responseOb = new ReponseOb(gameState: GameState.resume);
    _responseController.sink.add(responseOb);
  }


  pauseGame(){
    ReponseOb responseOb = new ReponseOb(gameState: GameState.pause);
    game.onPause();
    _responseController.sink.add(responseOb);
  }

  resumeGame(){
    ReponseOb responseOb = new ReponseOb(gameState: GameState.resume);
    game.onPlay();
    _responseController.sink.add(responseOb);
  }

  finishedGame(){
    ReponseOb responseOb = new ReponseOb(gameState: GameState.finished);
    _responseController.sink.add(responseOb);
  }

  reStartGame(){
    ReponseOb responseOb = new ReponseOb(gameState: GameState.start);
    // game.
    _responseController.sink.add(responseOb);
  }
}