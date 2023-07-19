import 'package:flame/components.dart';

import '../animal_safer_game.dart';

class Dirt extends SpriteComponent with HasGameRef<AnimalSaferGame> , HasHitboxes, Collidable {

  final String name;
  final double width;
  
  Dirt({required this.name,required this.width})
      : super(
          size: Vector2.all(width),
        );

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(name);
    return super.onLoad();
  }

}