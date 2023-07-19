class LevelOb{
  int level;
  List<RubbishType> rubbishList;
  int time;
  int totalScore;
  LevelOb({required this.level, required this.rubbishList, required this.time, required this.totalScore});
}


class RubbishType{
  String name;
  double width;
  int amount;

  RubbishType({required this.name,required this.width,required this.amount});
}