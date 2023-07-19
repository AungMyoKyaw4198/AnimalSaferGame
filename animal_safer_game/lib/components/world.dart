import 'package:flame/components.dart';

import '../animal_safer_game.dart';
 
class World extends SpriteComponent with HasGameRef<AnimalSaferGame> {
  final String name;
  World({required this.name});

  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite(name);
    size = sprite!.originalSize;
    return super.onLoad();
  }
}