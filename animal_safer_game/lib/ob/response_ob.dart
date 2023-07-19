class ReponseOb{
  MsgState? msgState; // Can Be Null
  dynamic data;
  ErrState? errState;
  GameState? gameState; // Can Be Null

  ReponseOb({this.msgState, this.data, this.errState, this.gameState});
}


enum MsgState{
  data,
  error,
  loading,
  other
}

enum ErrState{
  serverErr,  //500
  notFoundErr, //404
  noAuthErr,  
  unknownErr, 
}

enum GameState{
  start,
  pause,
  resume,
  finished,
}