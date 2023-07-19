class PlayerData{
  String name;
  String character;
  String characterFace;
  int level;
  int currentScore;
  double worldValue;

  PlayerData({
    required this.name,
    required this.character,
    required this.characterFace,
    required this.level,
    required this.currentScore,
    required this.worldValue
  });

  factory PlayerData.fromJson(Map<String, dynamic> parsedJson) {
        return new PlayerData(
            name: parsedJson['name'] ?? "",
            character: parsedJson['character'] ?? "characters/adventurer_spritesheet.png",
            characterFace: parsedJson['characterFace'] ?? "assets/images/characters/faces/adventurer.png",
            level: parsedJson['level'] ?? 0,
            currentScore: parsedJson['currentScore'] ?? 0,
            worldValue: parsedJson['worldValue'] ?? 0.0,
          );
      }

  Map<String, dynamic> toJson() {
        return {
          "name": this.name,
          "character": this.character,
          "characterFace": this.characterFace,
          "level": this.level,
          "currentScore": this.currentScore,
          "worldValue": this.worldValue,
        };
      }

}